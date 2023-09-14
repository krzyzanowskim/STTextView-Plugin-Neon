import Cocoa
import STTextView
import Neon

class STTextViewSystemInterface: TextSystemInterface {

    typealias AttributeProvider = (Neon.Token) -> [NSAttributedString.Key: Any]?

    private let textView: STTextView
    private let attributeProvider: AttributeProvider

    init(textView: STTextView, attributeProvider: @escaping AttributeProvider) {
        self.textView = textView
        self.attributeProvider = attributeProvider
    }

    func clearStyle(in range: NSRange) {
        guard let textRange = NSTextRange(range, in: textView.textContentManager) else {
            assertionFailure()
            return
        }

        textView.textLayoutManager.removeRenderingAttribute(.foregroundColor, for: textRange)
        if let defaultFont = textView.font {
            textView.addAttributes([.font: defaultFont], range: range)
        }
    }

    func applyStyle(to token: Neon.Token) {
        guard let attrs = attributeProvider(token),
              let textRange = NSTextRange(token.range, in: textView.textContentManager)
        else {
            return
        }

        for attr in attrs {
            textView.textLayoutManager.addRenderingAttribute(attr.key, value: attr.value, for: textRange)
        }
    }

    var length: Int {
        textView.textContentManager.length
    }

    var visibleRange: NSRange {
        guard let viewportRange = textView.textLayoutManager.textViewportLayoutController.viewportRange else {
            return .zero
        }

        return NSRange(viewportRange, provider: textView.textContentManager)
    }
}
