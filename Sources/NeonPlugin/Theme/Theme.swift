import Cocoa

public struct Theme: Decodable {

    public struct Value: Decodable {
        let color: Theme.Color
        let font: Theme.Font?

        public init(color: Theme.Color, font: Theme.Font? = nil) {
            self.color = color
            self.font = font
        }
    }

    let tokens: [TokenName: Theme.Value]

    public init(_ tokens: [TokenName : Theme.Value]) {
        self.tokens = tokens
    }
}

extension Theme {

    public struct Font: Decodable {
        public let value: NSFont

        enum CodingKeys: CodingKey {
            case fontName
            case size
        }

        public init(_ font: NSFont) {
            self.value = font
        }

        public func bold() -> Self {
            Theme.Font(NSFont(descriptor: value.fontDescriptor.withSymbolicTraits(.bold), size: value.pointSize)!)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let fontName = try container.decode(String.self, forKey: .fontName)
            let size = try container.decode(CGFloat.self, forKey: .size)
            value = NSFont(name: fontName, size: size)!
        }
    }

    public struct Color: Decodable {
        public let value: NSColor

        public init(_ color: NSColor) {
            value = color
        }

        public init(_ color: CGColor) {
            value = NSColor(cgColor: color)!
        }

        enum CodingKeys: CodingKey {
            case light
            case dark
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let lightColor = try NSColor(hexString: container.decode(String.self, forKey: .light))!
            let darkColor = try NSColor(hexString: container.decode(String.self, forKey: .dark))!

            self.value = NSColor(name: nil) { appearance in
                switch appearance.name {
                case .aqua, .vibrantLight, .accessibilityHighContrastAqua, .accessibilityHighContrastVibrantLight:
                    return lightColor
                case .darkAqua, .vibrantDark, .accessibilityHighContrastDarkAqua, .accessibilityHighContrastVibrantDark:
                    return darkColor
                default:
                    return lightColor
                }
            }
        }
    }
}

extension Theme {
    public static let `default` = Theme(
        [
            "string": Theme.Value(color: Color(NSColor(red: 153 / 255, green: 0, blue: 0, alpha: 1)), font: nil),
            "number": Theme.Value(color: Color(NSColor(red: 28 / 255, green: 0 / 255, blue: 207 / 255, alpha: 1)), font: nil),

            "keyword": Theme.Value(color: Color(NSColor(red: 155 / 255, green: 35 / 255, blue: 147 / 255, alpha: 1)), font: Font(NSFont.monospacedSystemFont(ofSize: 0, weight: .bold))),
            "include": Theme.Value(color: Color(NSColor(red: 155 / 255, green: 35 / 255, blue: 147 / 255, alpha: 1)), font: nil),
            "constructor": Theme.Value(color: Color(NSColor(red: 155 / 255, green: 35 / 255, blue: 147 / 255, alpha: 1)), font: Font(NSFont.monospacedSystemFont(ofSize: 0, weight: .bold))),
            "keyword.function": Theme.Value(color: Color(NSColor(red: 50 / 255, green: 109 / 255, blue: 116 / 255, alpha: 1)), font: nil),
            "keyword.return": Theme.Value(color: Color(NSColor(red: 155 / 255, green: 35 / 255, blue: 147 / 255, alpha: 1)), font: nil),
            "variable.builtin": Theme.Value(color: Color(NSColor(red: 50 / 255, green: 109 / 255, blue: 116 / 255, alpha: 1)), font: nil),
            "boolean": Theme.Value(color: Color(NSColor(red: 155 / 255, green: 35 / 255, blue: 147 / 255, alpha: 1)), font: nil),

            "type": Theme.Value(color: Color(NSColor(red: 11 / 255, green: 79 / 255, blue: 121 / 255, alpha: 1)), font: nil),

            "function.call": Theme.Value(color: Color(NSColor(red: 11 / 255, green: 79 / 255, blue: 121 / 255, alpha: 1)), font: nil),

            "variable": Theme.Value(color: Color(NSColor.textColor), font: nil),
            "property": Theme.Value(color: Color(NSColor(red: 50 / 255, green: 109 / 255, blue: 116 / 255, alpha: 1)), font: nil),
            "method": Theme.Value(color: Color(NSColor(red: 50 / 255, green: 109 / 255, blue: 116 / 255, alpha: 1)), font: nil),
            "parameter": Theme.Value(color: Color(NSColor.textColor), font: nil),
            "comment": Theme.Value(color: Color(NSColor.secondaryLabelColor), font: nil),
            "operator": Theme.Value(color: Color(NSColor.textColor), font: nil),

            .default: Theme.Value(color: Color(NSColor.textColor), font: Font(NSFont.monospacedSystemFont(ofSize: 0, weight: .regular)))
        ]
    )
}
