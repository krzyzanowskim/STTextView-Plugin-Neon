// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NeonPlugin",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "NeonPlugin",
            targets: ["NeonPlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/STTextView", from: "0.8.10"),
        .package(url: "https://github.com/ChimeHQ/Neon.git", from: "0.5.1"),
        .package(url: "https://github.com/alex-pinkus/tree-sitter-swift.git", commit: "eda05af7ac41adb4eb19c346883c0fa32fe3bdd8") // with-generated-files
    ],
    targets: [
        .target(
            name: "NeonPlugin",
            dependencies: [
                .product(name: "STTextView", package: "STTextView"),
                "Neon",
                .product(name: "TreeSitterSwift", package: "tree-sitter-swift")
            ]
        )
    ]
)
