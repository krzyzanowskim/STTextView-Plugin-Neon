[STTextView](https://github.com/krzyzanowskim/STTextView) Source Code Syntax Highlighting with [TreeSitter](https://tree-sitter.github.io/tree-sitter/) and [Neon](https://github.com/ChimeHQ/Neon).

https://github.com/user-attachments/assets/910b9862-c682-4dcc-ae0e-dbb55e8a3fe5

## Installation

Add the plugin package as a dependency of your application, then register/add it to the STTextView instance:

```swift
import STPluginNeon

textView.addPlugin(
    NeonPlugin(
        theme: .default,
        language: .swift
    )
)
```

SwiftUI:
```swift
import SwiftUI
import STTextViewUI
import STPluginNeon

struct ContentView: View {
    @State private var text: AttributedString = ""
    @State private var selection: NSRange?
    var body: some View {
        STTextViewUI.TextView(
            text: $text,
            selection: $selection,
            options: [.wrapLines, .highlightSelectedLine],
            plugins: [NeonPlugin(theme: .default, language: .swift)]
        )
        .textViewFont(.monospacedDigitSystemFont(ofSize: NSFont.systemFontSize, weight: .regular))
        .onAppear {
            loadContent()
        }
    }

    private func loadContent() {
        // (....)
        self.text = AttributedString(string)
    }
}
```

