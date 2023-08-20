import Cocoa

import STTextView
import STTextKitPlus

import Neon
import TreeSitterClient
import SwiftTreeSitter

// Swift
import TreeSitterSwift

public struct NeonPlugin: STPlugin {

    public init() { }

    public func setUp(context: Context) {

        context.events.onWillChangeText { affectedRange in
            let range = NSRange(affectedRange, in: context.textView.textContentManager)
            context.coordinator.willChangeContent(in: range)
        }

        context.events.onDidChangeText { affectedRange, replacementString in
            guard let replacementString else { return }

            let range = NSRange(affectedRange, in: context.textView.textContentManager)
            context.coordinator.didChangeContent(context.textView.textContentManager, in: range, delta: replacementString.utf16.count - range.length, limit: context.textView.textContentManager.length)
        }

        context.events.onDidLayoutViewport { viewportRange in
            context.coordinator.updateViewportRange(viewportRange)
        }
    }

    public func makeCoordinator(context: CoordinatorContext) -> Coordinator {
        Coordinator(textView: context.textView)
    }

    public class Coordinator {
        private(set) var highlighter: Neon.Highlighter?
        private let tsLanguage: SwiftTreeSitter.Language
        private let tsClient: TreeSitterClient
        private var prevViewportRange: NSTextRange?

        init(textView: STTextView) {
            tsLanguage = Language(language: tree_sitter_swift())

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

            highlighter = Neon.Highlighter(textInterface: STTextViewSystemInterface(textView: textView) { neonToken in
                switch neonToken.name {
                case "string":
                    return [.foregroundColor: NSColor.systemRed]
                case "keyword", "include", "constructor", "keyword.function", "keyword.return", "variable.builtin", "boolean":
                    return [.foregroundColor: NSColor.systemPink]
                case "type":
                    return [.foregroundColor: NSColor.systemBrown]
                case "function.call":
                    return [.foregroundColor: NSColor.systemIndigo]
                case "variable", "method", "parameter":
                    return [.foregroundColor: NSColor.systemTeal]
                case "comment":
                    return [.foregroundColor: NSColor.systemGray]
                default:
                    return [:]
                }
            }, tokenProvider: tokenProvider(textContentManager: textView.textContentManager))

            // Does not trigger initial parsing
            highlighter?.invalidate(.all)
        }

        private func tokenProvider(textContentManager: NSTextContentManager) -> Neon.TokenProvider? {

            let url = Bundle.main.resourceURL!.appendingPathComponent("TreeSitterSwift_TreeSitterSwift.bundle").appendingPathComponent("Contents/Resources/queries/highlights.scm")

            guard let highlightsQuery = try? tsLanguage.query(contentsOf: url) else {
                return nil
            }

            return tsClient.tokenProvider(with: highlightsQuery) { range, _ in
                textContentManager.attributedString(in: NSTextRange(range, provider: textContentManager))?.string
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

}
