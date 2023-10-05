import AppKit
import STTextView

import NeonPlugin

class EditorViewController: NSViewController {

    private var textView: STTextView!

    override func loadView() {
        let scrollView = STTextView.scrollableTextView()
        self.textView = scrollView.documentView as? STTextView
        self.view = scrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size = CGSize(width: 500, height: 500)


        textView.addPlugin(
            NeonPlugin(theme: .default, language: .swift)
        )

        textView.backgroundColor = .controlBackgroundColor
        textView.font = .monospacedSystemFont(ofSize: 0, weight: .regular)

        textView.string = """
        import Foundation

        func hello() {
            print("Hello World!")
        }
        """
    }
}
