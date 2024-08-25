import Cocoa
import STTextView

import Neon
import TreeSitterClient
import SwiftTreeSitter

// tree-sitter-xcframework
//import TreeSitter
import TreeSitterResource

@MainActor
public class Coordinator {
    private(set) var highlighter: Neon.Highlighter?
    private let language: TreeSitterLanguage
    private let tsLanguage: SwiftTreeSitter.Language
    private let tsClient: TreeSitterClient
    private var prevViewportRange: NSTextRange?

    init(textView: STTextView, theme: Theme, language: TreeSitterLanguage) {
        self.language = language
        tsLanguage = Language(language: language.parser)

        tsClient = try! TreeSitterClient(language: tsLanguage) { codePointIndex in
            guard let location = textView.textContentManager.location(at: codePointIndex),
                  let position = textView.textContentManager.position(location)
            else {
                return .zero
            }

            return Point(row: position.row, column: position.column)
        }


        tsClient.invalidationHandler = { [weak self] indexSet in
            self?.highlighter?.invalidate(.set(indexSet))
        }

        // set textview default font to theme default font
        textView.font = theme.font(forToken: "plain") ?? textView.font

        highlighter = Neon.Highlighter(textInterface: STTextViewSystemInterface(textView: textView) { neonToken in
            var attributes: [NSAttributedString.Key: Any] = [:]
            attributes[.font] = textView.font

            if let themeColor = theme.color(forToken: TokenName(neonToken.name)) {
                attributes[.foregroundColor] = themeColor

                if let themeFont = theme.font(forToken: TokenName(neonToken.name)) {
                    attributes[.font] = themeFont
                }
            } else if let themeDefaultColor = theme.color(forToken: "plain") {
                attributes[.foregroundColor] = themeDefaultColor

                if let themeFont = theme.font(forToken: TokenName(neonToken.name)) {
                    attributes[.font] = themeFont
                }
            }

            return !attributes.isEmpty ? attributes : nil
        }, tokenProvider: tokenProvider(textContentManager: textView.textContentManager))

        // initial parse of the whole content
        tsClient.willChangeContent(in: NSRange(textView.textContentManager.documentRange, in: textView.textContentManager))
        tsClient.didChangeContent(in: NSRange(textView.textContentManager.documentRange, in: textView.textContentManager),
                                  delta: textView.textContentManager.length,
                                  limit: textView.textContentManager.length,
                                  readHandler: Parser.readFunction(for: textView.textContentManager.attributedString(in: nil)?.string ?? ""),
                                  completionHandler: {
        })
    }

    private func tokenProvider(textContentManager: NSTextContentManager) -> Neon.TokenProvider? {

        guard let highlightsQuery = try? tsLanguage.query(contentsOf: language.highlightQueryURL!) else {
            return nil
        }

        return tsClient.tokenProvider(with: highlightsQuery) { range, _ in
            guard range.isEmpty == false else { return nil }
            return textContentManager.attributedString(in: NSTextRange(range, provider: textContentManager))?.string
        }
    }

    func updateViewportRange(_ range: NSTextRange?) {
        if range != prevViewportRange {
            highlighter?.visibleContentDidChange()
        }
        prevViewportRange = range
    }

    func willChangeContent(in range: NSRange) {
        tsClient.willChangeContent(in: range)
    }

    func didChangeContent(_ textContentManager: NSTextContentManager, in range: NSRange, delta: Int, limit: Int) {
        /// TODO: Instead get the *whole* string over and over (can be expensive for large documents)
        /// implement maybe a reader function that read what needed only (is it possible?)
        if let str = textContentManager.attributedString(in: nil)?.string {
            let readFunction = Parser.readFunction(for: str)
            tsClient.didChangeContent(in: range, delta: delta, limit: limit, readHandler: readFunction, completionHandler: {})
        }

    }
}
