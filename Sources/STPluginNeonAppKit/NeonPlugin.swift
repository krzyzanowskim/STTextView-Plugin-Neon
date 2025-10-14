import Cocoa

import STTextView

// tree-sitter-xcframework
//import TreeSitter
import TreeSitterResource

public struct NeonPlugin: STPlugin {
    private let theme: Theme
    private let language: TreeSitterLanguage

    public init(theme: Theme = .default, language: TreeSitterLanguage) {
        self.theme = theme
        self.language = language
    }

    public func setUp(context: any Context) {

        context.events.onWillChangeText { affectedRange, replacementString in
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
        Coordinator(textView: context.textView, theme: theme, language: language)
    }

}

