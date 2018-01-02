

import Foundation

public extension Collection {

    public func shuffle() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }

}

public extension MutableCollection where Index == Int {

    public mutating func shuffleInPlace() {
        if count < 2 {
            return
        }

        for i in startIndex..<endIndex {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            self.swapAt(i, j)
        }
    }

}
