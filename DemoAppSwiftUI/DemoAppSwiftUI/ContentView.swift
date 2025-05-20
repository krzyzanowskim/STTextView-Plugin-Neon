//
//  ContentView.swift
//  DemoAppSwiftUI
//
//  Created by Stef Kors on 05/10/2023.
//

import SwiftUI

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import STTextViewSwiftUI
typealias Font = NSFont
typealias Color = NSColor
#endif
#if canImport(UIKit)
import STTextViewSwiftUIUIKit
typealias Font = UIFont
typealias Color = UIColor
#endif

import STPluginNeon

@MainActor
struct ContentView: View {
    @State private var text: AttributedString = ""
    @State private var selection: NSRange?
    @State private var font = Font.monospacedSystemFont(ofSize: 0, weight: .medium)
    
    var body: some View {
        VStack(spacing: 0) {
            TextView(
                text: $text,
                selection: $selection,
                options: [.wrapLines, .highlightSelectedLine, .showLineNumbers],
                plugins: [NeonPlugin(theme: .default, language: .go)]
            )
            .textViewFont(font)

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
