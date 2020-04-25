

import Foundation

public protocol Occupiable {
    var isEmpty: Bool { get }
    var isNotEmpty: Bool { get }
}

public extension Occupiable {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension String: Occupiable { }
extension Array: Occupiable { }
extension Dictionary: Occupiable { }
extension Set: Occupiable { }

public extension Optional where Wrapped: Occupiable {
    var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }

    var isNotNilNotEmpty: Bool {
        return !isNilOrEmpty
    }
}
