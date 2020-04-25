

import Foundation

// MARK: - Getter

public extension Dictionary {

    func random() -> Value {
        let index: Int = Int(arc4random_uniform(UInt32(self.count)))
        return Array(self.values)[index]
    }
    
    func toJSONData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            return nil
        }
    }

}

// MARK: - Transform

public extension Dictionary {

    func union(values: Dictionary...) -> Dictionary {
        var result = self
        values.forEach { dictionary in
            dictionary.forEach { key, value in
                result.updateValue(value, forKey: key)
            }
        }
        return result
    }

    mutating func merge<K, V>(with dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                guard let value = value as? Value, let key = key as? Key else {
                    continue
                }

                self.updateValue(value, forKey: key)
            }
        }
    }
}

// MARK: - Helpers

public extension Dictionary {

    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    func testAll(test: (Key, Value) -> (Bool)) -> Bool {
        for (key, value) in self {
            if !test(key, value) {
                return false
            }
        }
        return true
    }
}

public extension Dictionary where Value: Equatable {

    func difference(with dictionaries: [Key: Value]...) -> [Key: Value] {
        var result = self
        for dictionary in dictionaries {
            for (key, value) in dictionary {
                if result.has(key: key) && result[key] == value {
                    result.removeValue(forKey: key)
                }
            }
        }
        return result
    }
}

func += <KeyType, ValueType> (left: inout Dictionary<KeyType, ValueType>,
                                     right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

func - <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.difference(with: second)
}

func | <K: Hashable, V> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.union(values: second)
}
