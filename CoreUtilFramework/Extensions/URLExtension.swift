

import Foundation

public extension URL {

    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self as URL, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }

        var parameters = [String: String]()
        queryItems.forEach {
            parameters[$0.name] = $0.value
        }
        return parameters
    }

    public func addSkipBackupAttribute() throws {
        try (self as NSURL).setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
    }

}
