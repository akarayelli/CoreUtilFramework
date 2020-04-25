

import Foundation

// MARK: - Subscript

public extension Array {

    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}

// MARK: - Delete

public extension Array where Element : Equatable {

    mutating func remove(object: Iterator.Element) -> Bool {
        if let index = self.firstIndex(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }

    mutating func remove(objects: Element) {
        for idx in self.indexes(of: objects).reversed() {
            self.remove(at: idx)
        }
    }

}

// MARK: - Getter

public extension Array {

    func random() -> Element? {
        guard self.count > 0 else {
            return nil
        }

        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }

    func get(index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }

    func takeMax(number: Int) -> Array {
        return Array(self[0..<Swift.max(0, Swift.min(number, count))])
    }
    
    mutating func shuffle() {
        for i in (1 ..< count).reversed() {
            let j = Int.random(max: i - 1)
            self.swapAt(i, j)
        }
    }
    
    func shuffled() -> [Element] {
        var array = self
        array.shuffle()
        return array
    }
    
    func toJSONString() -> String? {
        guard let data = toJSONData() else {
            return nil
        }
        return String.init(data: data, encoding: .utf8)
    }
    
    func toJSONData() -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return data
        } catch {
            return nil
        }
    }

}

public extension Array where Element : Equatable {

    func indexes(of object: Element) -> [Int] {
        var indexes = [Int]()
        for index in 0..<self.count {
            if self[index] == object {
                indexes.append(index)
            }
        }
        return indexes
    }

    func lastIndex(of object: Element) -> Int? {
        return indexes(of: object).last
    }

    func difference(with values: [Element]...) -> [Element] {
        var result = [Element]()
        elements: for element in self {
            for value in values {
                if value.contains(element) {
                    continue elements
                }
            }
            result.append(element)
        }
        return result
    }

    func intersection(for values: [Element]...) -> Array {
        var result = self
        var intersection = Array()

        for (i, value) in values.enumerated() {
            if i > 0 {
                result = intersection
                intersection = Array()
            }

            value.forEach {
                if result.contains($0) {
                    intersection.append($0)
                }
            }
        }
        return intersection
    }

    func union(values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return result
    }

}

// MARK: - Update

public extension Array {

    func reverse(index: Int) -> Int {
        return Swift.max(self.count - 1 - index, 0)
    }

}

// MARK: - Helpers

public extension Array {

    func contains<T>(instanceOf object: T) -> Bool {
        for item in self {
            if type(of: item) == type(of: object) {
                return true
            }
        }
        return false
    }


    func testAll(test: (Element) -> Bool) -> Bool {
        for item in self {
            if !test(item) {
                return false
            }
        }
        return true
    }

}

public extension Array where Element : Equatable {

    func contains(items: Element...) -> Bool {
        return items.testAll { self.firstIndex(of: $0) ?? 0 >= 0 }
    }

    func contains(array: [Element]) -> Bool {
        for item in array {
            if self.contains(item) == false {
                return false
            }
        }
        return true
    }

}
