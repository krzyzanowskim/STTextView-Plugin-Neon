import AppKit
import STTextView

import STPluginNeon

class EditorViewController: NSViewController {

    private var textView: STTextView!

    override func loadView() {
        let scrollView = STTextView.scrollableTextView()
        scrollView.drawsBackground = true
        self.textView = scrollView.documentView as? STTextView
        self.view = scrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size = CGSize(width: 700, height: 500)

        let sourceCodeTheme = Theme(
            ///Themes.xcassets
            colors: Theme.Colors(bundle: Bundle(path: Bundle.main.resourcePath! + "/STTextView-Plugin-Neon_STPluginNeon.bundle")!, name: "neon.plugin.default"),
            fonts: Theme.Fonts(bundle: Bundle(path: Bundle.main.resourcePath! + "/STTextView-Plugin-Neon_STPluginNeon.bundle")!, name: "neon.plugin.default")
        )

        textView.addPlugin(
            NeonPlugin(theme: sourceCodeTheme, language: .swift)
        )

        let paragraph = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraph.lineHeightMultiple = 1.2
        textView.defaultParagraphStyle = paragraph

        textView.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        textView.isHorizontallyResizable = false
        textView.highlightSelectedLine = false
        textView.showsLineNumbers = false
        textView.text = """
        // https://www.swift.org/getting-started/library-swiftpm/
        import Foundation

        struct Email: CustomStringConvertible {
            var description: String

            public init(_ emailString: String) throws {
                let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"#
                guard let _ = emailString.range(of: regex, options: .regularExpression) else {
                    throw InvalidEmailError(email: emailString)
                }
                self.description = emailString
            }
        }

        private struct InvalidEmailError: Error {
            let email: String
        }
        """
    }

    @IBAction func toggleTextWrap(_ sender: Any?) {
        textView.isHorizontallyResizable.toggle()
    }

    @IBAction func toggleInvisibleCharacters(_ sender: Any?) {
        textView.showsInvisibleCharacters.toggle()
    }

    @IBAction func toggleGutter(_ sender: Any?) {
        textView.showsLineNumbers.toggle()
    }

    @IBAction func toggleLineHighlight(_ sender: Any?) {
        textView.highlightSelectedLine.toggle()
        textView.gutterView?.highlightSelectedLine.toggle()
    }
}
