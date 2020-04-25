

import Foundation

// MARK: - Subscript

public extension UserDefaults {

    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

}

// MARK: - Helpers

public extension UserDefaults {

    static func contains(key: String) -> Bool {
        return self.standard.contains(key: key)
    }

    func contains(key: String) -> Bool {
        return self.dictionaryRepresentation().keys.contains(key)
    }

    func reset() {
        for key in Array(UserDefaults.standard.dictionaryRepresentation().keys) {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }

}
