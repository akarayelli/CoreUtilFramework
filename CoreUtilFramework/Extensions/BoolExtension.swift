
import Foundation

extension Bool {
    public mutating func toggle() -> Bool {
        self = !self
        return self
    }

    public func toInt() -> Int {
        return self ? 1 : 0
    }
}
