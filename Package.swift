// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "STTextView-Plugin-Neon",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "STTextView-Plugin-Neon",
            targets: ["NeonPlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/STTextView", from: "1.0.0"),
        .package(url: "https://github.com/ChimeHQ/Neon.git", from: "0.6.0"),
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
        .package(path: "TreeSitterLanguages")
    ],
    targets: [
        .target(
            name: "NeonPlugin",
            dependencies: [
                .product(name: "STTextView", package: "STTextView"),
                .product(name: "Neon", package: "Neon"),
                .target(name: "TreeSitterResource")
            ],
            resources: [.process("Themes.xcassets")]
        ),
        .target(
            name: "TreeSitterResource",
            dependencies: [
                .product(name: "SwiftTreeSitter", package: "SwiftTreeSitter"),
                .product(name: "TreeSitterBash", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterBashQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterC", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterCQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterCPP", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterCPPQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterCSharp", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterCSharpQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterCSS", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterCSSQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterGo", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterGoQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterHTML", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterHTMLQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterJava", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterJavaQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterJavaScript", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterJavaScriptQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterJSON", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterJSONQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterMarkdown", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterMarkdownQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterPHP", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterPHPQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterPython", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterPythonQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterRuby", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterRubyQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterRust", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterRustQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterSwift", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterSwiftQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterSQL", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterSQLQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterTOML", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterTOMLQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterTypeScript", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterTypeScriptQueries", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterYAML", package: "TreeSitterLanguages"),
                .product(name: "TreeSitterYAMLQueries", package: "TreeSitterLanguages")
            ]
        )
    ]
)
