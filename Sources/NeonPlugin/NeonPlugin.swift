import Cocoa

import STTextView

public struct NeonPlugin: STPlugin {
    private let theme: Theme

    public init(theme: Theme = .default) {
        self.theme = theme
    }

    public func setUp(context: Context) {

        context.events.onWillChangeText { affectedRange in
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
        Coordinator(textView: context.textView, theme: theme)
    }

}

