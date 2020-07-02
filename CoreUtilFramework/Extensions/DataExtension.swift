import Foundation

public extension Data {
    func toJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            return nil
        }
    }

    func toString(_ encoding: String.Encoding = String.Encoding.utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    func dataToFile(fileNameAndExtension: String) -> URL? {
        let data = self
        let temporaryFolder = FileManager.default.temporaryDirectory
        let temporaryFileURL = temporaryFolder.appendingPathComponent(fileNameAndExtension)
        do {
            try data.write(to: temporaryFileURL)
            return temporaryFileURL
        } catch {
            print(error)
        }
        return nil
    }
}
