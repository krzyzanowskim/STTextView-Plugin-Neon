import Foundation
import AppKit

extension Theme {
    
    public static let `default` = Theme(
        colors: Colors(bundle: Bundle.module, name: "neon.plugin.default"),
        tokensCustomFontDict: [
            "default": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
            "keyword": NSFont.monospacedSystemFont(ofSize: 0, weight: .bold),
            "constructor": NSFont.monospacedSystemFont(ofSize: 0, weight: .bold)
            
        ]
    )
}
