[STTextView](https://github.com/krzyzanowskim/STTextView) Source Code Syntax Highlighting with [TreeSitter](https://tree-sitter.github.io/tree-sitter/) and [Neon](https://github.com/ChimeHQ/Neon).

## Installation

Add the plugin package as a dependency of your application, then register/add it to the STTextView instance:

```swift
import NeonPlugin

textView.addPlugin(
    NeonPlugin(
        theme: .default,
        language: .go
    )
)
```

SwiftUI:
```swift
import SwiftUI
import STTextViewUI
import NeonPlugin

struct ContentView: View {
    @State private var text: AttributedString = ""
    @State private var selection: NSRange?
    var body: some View {
        STTextViewUI.TextView(
            text: $text,
            selection: $selection,
            options: [.wrapLines, .highlightSelectedLine],
            plugins: [NeonPlugin(theme: .default, language: .go)]
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

<img width="612" alt="Default Theme" src="https://github.com/krzyzanowskim/STTextView-Plugin-Neon/assets/758033/03c35889-da7f-48c1-8982-77430eb69a20">

