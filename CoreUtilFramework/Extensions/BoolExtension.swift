
import Foundation

public extension Bool {
    mutating func toggle() -> Bool {
        self = !self
        return self
    }

    func toInt() -> Int {
        return self ? 1 : 0
    }
}
