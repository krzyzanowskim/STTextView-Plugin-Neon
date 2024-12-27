import Foundation

import TreeSitter

import TreeSitterBash
import TreeSitterBashQueries
import TreeSitterC
import TreeSitterCQueries
import TreeSitterCPP
import TreeSitterCPPQueries
import TreeSitterCSharp
import TreeSitterCSharpQueries
import TreeSitterCSS
import TreeSitterCSSQueries
import TreeSitterGo
import TreeSitterGoQueries
import TreeSitterHTML
import TreeSitterHTMLQueries
import TreeSitterJava
import TreeSitterJavaQueries
import TreeSitterJavaScript
import TreeSitterJavaScriptQueries
import TreeSitterJSON
import TreeSitterJSONQueries
import TreeSitterMarkdown
import TreeSitterMarkdownQueries
import TreeSitterPHP
import TreeSitterPHPQueries
import TreeSitterPython
import TreeSitterPythonQueries
import TreeSitterRuby
import TreeSitterRubyQueries
import TreeSitterRust
import TreeSitterRustQueries
import TreeSitterSwift
import TreeSitterSwiftQueries
import TreeSitterSQL
import TreeSitterSQLQueries
import TreeSitterTOML
import TreeSitterTOMLQueries
import TreeSitterTypeScript
import TreeSitterTypeScriptQueries
import TreeSitterYAML
import TreeSitterYAMLQueries

public enum TreeSitterLanguage: CaseIterable, Hashable {
    case bash
    case c
    case cpp
    case csharp
    case css
    case go
    case html
    case java
    case javascript
    case json
    case markdown
    case php
    case python
    case ruby
    case rust
    case swift
    case sql
    case toml
    case typescript
    case yaml

    public var parser: OpaquePointer {
        switch self {
        case .bash:
            tree_sitter_bash()
        case .c:
            tree_sitter_c()
        case .cpp:
            tree_sitter_cpp()
        case .csharp:
            tree_sitter_c_sharp()
        case .css:
            tree_sitter_css()
        case .go:
            tree_sitter_go()
        case .html:
            tree_sitter_html()
        case .java:
            tree_sitter_java()
        case .javascript:
            tree_sitter_javascript()
        case .json:
            tree_sitter_json()
        case .markdown:
            tree_sitter_markdown()
        case .php:
            tree_sitter_php()
        case .python:
            tree_sitter_python()
        case .ruby:
            tree_sitter_ruby()
        case .rust:
            tree_sitter_rust()
        case .swift:
            tree_sitter_swift()
        case .sql:
            tree_sitter_sql()
        case .toml:
            tree_sitter_toml()
        case .typescript:
            tree_sitter_typescript()
        case .yaml:
            tree_sitter_yaml()
        }
    }

    public var highlightQueryURL: URL? {
        switch self {
        case .bash:
            TreeSitterBashQueries.Query.highlightsFileURL
        case .c:
            TreeSitterCQueries.Query.highlightsFileURL
        case .cpp:
            TreeSitterCPPQueries.Query.highlightsFileURL
        case .csharp:
            TreeSitterCSharpQueries.Query.highlightsFileURL
        case .css:
            TreeSitterCSSQueries.Query.highlightsFileURL
        case .go:
            TreeSitterGoQueries.Query.highlightsFileURL
        case .html:
            TreeSitterHTMLQueries.Query.highlightsFileURL
        case .java:
            TreeSitterJavaQueries.Query.highlightsFileURL
        case .javascript:
            TreeSitterJavaScriptQueries.Query.highlightsFileURL
        case .json:
            TreeSitterJSONQueries.Query.highlightsFileURL
        case .markdown:
            TreeSitterMarkdownQueries.Query.highlightsFileURL
        case .php:
            TreeSitterPHPQueries.Query.highlightsFileURL
        case .python:
            TreeSitterPythonQueries.Query.highlightsFileURL
        case .ruby:
            TreeSitterRubyQueries.Query.highlightsFileURL
        case .rust:
            TreeSitterRustQueries.Query.highlightsFileURL
        case .swift:
            TreeSitterSwiftQueries.Query.highlightsFileURL
        case .sql:
            TreeSitterSQLQueries.Query.highlightsFileURL
        case .toml:
            TreeSitterTOMLQueries.Query.highlightsFileURL
        case .typescript:
            TreeSitterTypeScriptQueries.Query.highlightsFileURL
        case .yaml:
            TreeSitterYAMLQueries.Query.highlightsFileURL
        }
    }

    public var localsQueryURL: URL? {
        switch self {
        case .bash:
            nil
        case .c:
            nil
        case .cpp:
            nil
        case .csharp:
            nil
        case .css:
            nil
        case .go:
            nil
        case .html:
            nil
        case .java:
            nil
        case .javascript:
            TreeSitterJavaScriptQueries.Query.localsFileURL
        case .json:
            nil
        case .markdown:
            nil
        case .php:
            nil
        case .python:
            nil
        case .ruby:
            TreeSitterRubyQueries.Query.localsFileURL
        case .rust:
            nil
        case .swift:
            TreeSitterSwiftQueries.Query.localsFileURL
        case .sql:
            nil
        case .toml:
            nil
        case .typescript:
            TreeSitterTypeScriptQueries.Query.localsFileURL
        case .yaml:
            nil
        }
    }
}
