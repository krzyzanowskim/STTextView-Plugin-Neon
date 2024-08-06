import Cocoa

public struct Theme {
    
    // MARK: - Props
    let colors: Colors
    let tokensCustomFontDict: [TokenName: NSFont]
    
    // MARK: - Lifecycle
    public init(colors: Colors, tokensCustomFontDict: [TokenName: NSFont] = [:]) {
        self.colors = colors
        self.tokensCustomFontDict = tokensCustomFontDict
    }
    
    public var defaultFont: NSFont? {
        tokensCustomFontDict["default"]
    }
    
    public var defaultColor: NSColor? {
        color(forToken: "default")
    }
    
    public func color(forToken tokenName: TokenName) -> NSColor? {
        colors.color(forToken: tokenName)
    }
    
    public func font(forToken tokenName: TokenName) -> NSFont? {
        return tokensCustomFontDict[tokenName]
    }
}

extension Theme {
    
    public struct Colors {
        
        let bundle: Bundle
        let name: String
        
        public init(bundle: Bundle, name: String) {
            self.bundle = bundle
            self.name = name
        }
        
        func color(forToken tokenName: TokenName) -> NSColor? {
            let colorName = "\(name)/\(tokenName)"
            return NSColor(named: colorName, bundle: bundle)
        }
    }
}
