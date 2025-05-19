import Foundation
import UIKit

extension Theme {

    public static let `default` = Theme(
        colors: Colors(bundle: Bundle.module, name: "neon.plugin.default"),
        fonts: Fonts(bundle: Bundle.module, name: "neon.plugin.default")
    )
}
