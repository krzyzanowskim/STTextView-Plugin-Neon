//
//  ContentView.swift
//  DemoAppSwiftUI
//
//  Created by Stef Kors on 05/10/2023.
//

import SwiftUI
import STTextViewUI
import NeonPlugin

struct ContentView: View {
    @State private var text: AttributedString = ""
    @State private var selection: NSRange?
    @State private var counter = 0
    var body: some View {
        VStack(spacing: 0) {
            STTextViewUI.TextView(
                text: $text,
                selection: $selection,
                options: [.wrapLines, .highlightSelectedLine],
                plugins: [NeonPlugin(theme: .default, language: .go)]
            )
            .textViewFont(.monospacedDigitSystemFont(ofSize: NSFont.systemFontSize, weight: .regular))

            HStack {
                if let selection {
                    Text("Location: \(selection.location)")
                } else {
                    Text("No selection")
                }
                Spacer()
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
        }
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
