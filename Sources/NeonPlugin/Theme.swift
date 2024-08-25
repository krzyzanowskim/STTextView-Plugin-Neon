import Cocoa

public struct Theme {
    
    // MARK: - Props
    let colors: Colors
    let fonts: Fonts

    // MARK: - Lifecycle
    public init(colors: Colors, fonts: Fonts) {
        self.colors = colors
        self.fonts = fonts
    }
    
    public func color(forToken tokenName: TokenName) -> NSColor? {
        colors.color(forToken: tokenName)
    }
    
    public func font(forToken tokenName: TokenName) -> NSFont? {
        fonts.font(forToken: tokenName)
    }

    public struct Colors {
        
        let colors: [TokenName: NSColor]

        public init(bundle: Bundle, name: String) {
            colors = [
                "plain": NSColor(named: "\(name)/plain", bundle: bundle)!,
                "boolean": NSColor(named: "\(name)/boolean", bundle: bundle)!,
                "comment": NSColor(named: "\(name)/comment", bundle: bundle)!,
                "constructor": NSColor(named: "\(name)/constructor", bundle: bundle)!,
                "function.call": NSColor(named: "\(name)/function.call", bundle: bundle)!,
                "include": NSColor(named: "\(name)/include", bundle: bundle)!,
                "keyword": NSColor(named: "\(name)/keyword", bundle: bundle)!,
                "keyword.function": NSColor(named: "\(name)/keyword.function", bundle: bundle)!,
                "keyword.return": NSColor(named: "\(name)/keyword.return", bundle: bundle)!,
                "method": NSColor(named: "\(name)/method", bundle: bundle)!,
                "number": NSColor(named: "\(name)/number", bundle: bundle)!,
                "operator": NSColor(named: "\(name)/operator", bundle: bundle)!,
                "parameter": NSColor(named: "\(name)/parameter", bundle: bundle)!,
                "punctuation.special": NSColor(named: "\(name)/punctuation.special", bundle: bundle)!,
                "string": NSColor(named: "\(name)/string", bundle: bundle)!,
                "text.literal": NSColor(named: "\(name)/text.literal", bundle: bundle)!,
                "text.title": NSColor(named: "\(name)/text.title", bundle: bundle)!,
                "type": NSColor(named: "\(name)/type", bundle: bundle)!,
                "variable.builtin": NSColor(named: "\(name)/variable.builtin", bundle: bundle)!,
                "variable": NSColor(named: "\(name)/variable", bundle: bundle)!
            ]
        }
        
        public func color(forToken tokenName: TokenName) -> NSColor? {
            colors[tokenName]
        }
    }

    public struct Fonts {

        let fonts: [TokenName: NSFont]

        public init(bundle: Bundle, name: String) {
            fonts = [
                "plain": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "boolean": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "comment": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "constructor": NSFont.monospacedSystemFont(ofSize: 0, weight: .medium),
                "function.call": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "include": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "keyword": NSFont.monospacedSystemFont(ofSize: 0, weight: .medium),
                "keyword.function": NSFont.monospacedSystemFont(ofSize: 0, weight: .medium),
                "keyword.return": NSFont.monospacedSystemFont(ofSize: 0, weight: .medium),
                "method": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "number": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "operator": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "parameter": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "punctuation.special": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "string": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "text.literal": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "text.title": NSFont.monospacedSystemFont(ofSize: 0, weight: .medium),
                "type": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "variable.builtin": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular),
                "variable": NSFont.monospacedSystemFont(ofSize: 0, weight: .regular)
            ]

        }

        public func font(forToken tokenName: TokenName) -> NSFont? {
            fonts[tokenName]
        }
    }
}
