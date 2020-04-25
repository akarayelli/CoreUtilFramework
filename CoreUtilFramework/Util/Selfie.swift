

import Foundation

// Inspired from http://ericasadun.com/2016/04/18/default-reflection/
public protocol Selfie: CustomStringConvertible {}

public extension Selfie {

    var description: String {
        let mirror = Mirror(reflecting: self)
        return "\(mirror.subjectType)( \(mirror.children.map({ "\($0!): \($1)"}).joined(separator: ", ")))"
    }

}
