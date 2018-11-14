

import Foundation


public extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}


// MARK - Subscript

public extension String {

    public subscript(integerIndex: Int) -> Character {
        return self[index(startIndex, offsetBy: integerIndex)]
    }

    public subscript(integerRange: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: integerRange.lowerBound)
        let end = index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start..<end])
    }

}

// MARK: - Init

public extension String {

    init?(value: Float, maxDigits: Int) {
        let numberFormatter = SNumberFormatter.sharedInstance
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = maxDigits
        guard let string = numberFormatter.string(for: value) else {
            return nil
        }
        self = string
    }

    init?(value: Double, maxDigits: Int) {
        let numberFormatter = SNumberFormatter.sharedInstance
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = maxDigits
        guard let string = numberFormatter.string(for: value) else {
            return nil
        }
        self = string
    }

}

// MARK - Helpers

public extension String {

    public static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    public var length: Int {
        return self.count
    }

    public func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        let characterSet = NSCharacterSet.whitespacesAndNewlines
        let newText = self.trimmingCharacters(in: characterSet)
        return newText.isEmpty
    }

    func contains(text: String) -> Bool {
        return self.range(of: text) != nil
    }

    public func contains(text: String, compareOption: NSString.CompareOptions) -> Bool {
        return self.range(of: text, options: compareOption) != nil
    }

    public func containsEmoji() -> Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }

}

// MARK: - Getter

public extension String {

    public var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }

        let text = self
        if let detector = detector {
            detector.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.count), using: {
                (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let result = result,
                    let url = result.url {
                    urls.append(url as URL)
                }
            })
        }
        return urls
    }

}

// MARK: - Updating

public extension String {

    public mutating func trim() {
        self = trimmed()
    }

    public func trimmed() -> String {
        return components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: "")
    }

    public mutating func truncate(limit: Int) {
        self = truncated(limit: limit)
    }

    public func truncated(limit: Int) -> String {
        if self.length > limit {
            var truncatedString = self[0..<limit]
            truncatedString = truncatedString.appending("...")
            return truncatedString
        }
        return self
    }

    public var capitalizeFirst: String {
        //let result = replacingCharacters(in: Range(startIndex..<startIndex), with: String(self[startIndex]).capitalized)
        let result = prefix(1).uppercased() + self.lowercased().dropFirst()
        return result
    }

}

// MARk - Validator

public extension String {

    public func isNumber() -> Bool {
        if let _ = SNumberFormatter.sharedInstance.number(from: self) {
            return true
        }
        return false
    }

    public var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    public var isAlphanumeric: Bool {
        return !isEmpty && (isAlphabetic(containsTurkishChars: true) || isNumber())
    }
    
    public func isAlphabetic(containsTurkishChars: Bool) -> Bool
    {
        if self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return false
        }
        return true
    }
    
    
    public func isEmpty() -> Bool!{
        if ( self == ""){
            return true
        }
        
        return false
    }
}

extension String {
    public var words: [String] {
        var words: [String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) { word,_,_,_ in
            guard let word = word else { return }
            words.append(word)
        }
        return words
    }
    
    public func substring(start: Int, end: Int) -> String
    {
        if (start < 0 || start > self.count) {
            return ""
        }
        else if end < 0 || end > self.count {
            return ""
        }
        
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        
        return String(self[startIndex..<endIndex])
    }
}


public extension String {
    
    public func underlinedAttributedString() -> NSMutableAttributedString {
        
        
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.underlineStyle.rawValue): NSUnderlineStyle.styleSingle.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(string: self,
                                                        attributes: yourAttributes)
        
        return attributeString
        
        
    }
    
    public func boldWordsInString(wordsToBold : [String], font: UIFont, boldFont: UIFont ) -> NSAttributedString{
        
        let attributedString = NSMutableAttributedString(string: self, attributes:[NSAttributedStringKey.font:font])
        
        let boldFontAttribute = [NSAttributedStringKey.font: boldFont]
        
        for stringToBold in wordsToBold
        {
            attributedString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: stringToBold))
        }
        
        
        return attributedString
    }
}

public extension String{
    
    public static func generateRandomValue(length: Int) -> String{
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: length)
        
        for _ in 1...length{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString as String
    }
    
}


