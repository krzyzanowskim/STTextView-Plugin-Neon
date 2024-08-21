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
        textView.addAttributes([.font: textView.font], range: range)
    }

    func applyStyle(to token: Neon.Token) {
        guard let attrs = attributeProvider(token),
              let textRange = NSTextRange(token.range, in: textView.textContentManager)
        else {
            return
        }

        for attr in attrs {
            if attr.key == .foregroundColor {
                textView.textLayoutManager.addRenderingAttribute(.foregroundColor, value: attr.value, for: textRange)
            } else {
                textView.addAttributes([attr.key: attr.value], range: token.range)
            }
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
