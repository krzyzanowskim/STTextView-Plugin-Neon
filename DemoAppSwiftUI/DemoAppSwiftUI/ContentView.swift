//
//  ContentView.swift
//  DemoAppSwiftUI
//
//  Created by Stef Kors on 05/10/2023.
//

import SwiftUI
import STTextViewSwiftUI
import STPluginNeon

@MainActor
struct ContentView: View {
    @State private var text: AttributedString = ""
    @State private var selection: NSRange?
    var body: some View {
        TextView(
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
        let string = """
        package main

        import "fmt"

        func main() {
            fmt.Println("hello world")
        }
        """
        self.text = AttributedString(string)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
