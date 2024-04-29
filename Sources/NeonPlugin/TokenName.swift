import Foundation

public struct TokenName: Hashable, Decodable, CustomStringConvertible, ExpressibleByStringLiteral {

    public static let `default`: TokenName = "EB6F2FBA-B90E-41BC-874E-67916516D889"

    private let value: String

    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }

    public init(_ string: StringLiteralType) {
        self.value = string
    }

    public var description: String {
        value
    }
}
