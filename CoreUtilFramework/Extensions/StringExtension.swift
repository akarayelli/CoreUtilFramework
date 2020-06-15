

import Foundation


public extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}


// MARK - Subscript

public extension String {

    subscript(integerIndex: Int) -> Character {
        return self[index(startIndex, offsetBy: integerIndex)]
    }

    subscript(integerRange: Range<Int>) -> String {
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

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    var length: Int {
        return self.count
    }

    func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        let characterSet = NSCharacterSet.whitespacesAndNewlines
        let newText = self.trimmingCharacters(in: characterSet)
        return newText.isEmpty
    }

    func contains(text: String) -> Bool {
        return self.range(of: text) != nil
    }

    func contains(text: String, compareOption: NSString.CompareOptions) -> Bool {
        return self.range(of: text, options: compareOption) != nil
    }

    func containsEmoji() -> Bool {
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

    var extractURLs: [URL] {
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

    mutating func trim() {
        self = trimmed()
    }

    func trimmed() -> String {
        return components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: "")
    }

    mutating func truncate(limit: Int) {
        self = truncated(limit: limit)
    }

    func truncated(limit: Int) -> String {
        if self.length > limit {
            var truncatedString = self[0..<limit]
            truncatedString = truncatedString.appending("...")
            return truncatedString
        }
        return self
    }

    var capitalizeFirst: String {
        //let result = replacingCharacters(in: Range(startIndex..<startIndex), with: String(self[startIndex]).capitalized)
        let result = prefix(1).uppercased() + self.lowercased().dropFirst()
        return result
    }

}

// MARk - Validator

public extension String {

    func isNumber() -> Bool {
        if let _ = SNumberFormatter.sharedInstance.number(from: self) {
            return true
        }
        return false
    }

    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    var isAlphanumeric: Bool {
        return !isEmpty && (isAlphabetic(containsTurkishChars: true) || isNumber())
    }
    
    func isAlphabetic(containsTurkishChars: Bool) -> Bool
    {
        if self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return false
        }
        return true
    }
    
    func isValidCitizenshipID() -> Bool!{
        
        let digits = self.description.map { Int(String($0)) ?? 0 }
            
        if digits.count == 11
        {
            if (digits.first != 0)
            {
                let first   = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
                let second  = (digits[1] + digits[3] + digits[5] + digits[7])
                    
                let digit10 = (first - second) % 10
                let digit11 = (digits[0] + digits[1] + digits[2] + digits[3] + digits[4] + digits[5] + digits[6] + digits[7] + digits[8] + digits[9]) % 10
                    
                if (digits[10] == digit11) && (digits[9] == digit10)
                {
                    return true
                }
            }
        }
        return false
    }
    
    
    func isValidTaxIdentityNumber() -> Bool{
        if self.count == 10{
            var x = [Int]()
            var y = [Int]()
            var result = 0
            
            for i in 0..<9{
                guard let characterInt = Int("\(self[i])") else { return false }
                let value = (characterInt + 9-i) % 10
                x.append(value)
                
                let powInt = Int(truncating: NSDecimalNumber(decimal: pow(2, 9-i)))
                var value2 = (value * powInt) % 9
                y.append(value2)
                
                if value != 0 && value2 == 0 {
                    value2 = 9
                }
                result += value2
            }
            
            if result % 10 == 0{
                result = 0
            }
            else{
                result = (10 - (result % 10))
            }
            
            guard let ninthCharacterInt = Int("\(self[9])") else { return false }
            return (result == ninthCharacterInt)
        }
        else{
            return false
        }
    }
    
    func isEmpty() -> Bool!{
        if ( self == ""){
            return true
        }
        
        return false
    }
}

public extension String {
    var words: [String] {
        var words: [String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) { word,_,_,_ in
            guard let word = word else { return }
            words.append(word)
        }
        return words
    }
    
    func substring(start: Int, end: Int) -> String
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
    
    func underlinedAttributedString() -> NSMutableAttributedString {
        
        
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue): NSUnderlineStyle.single.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(string: self,
                                                        attributes: yourAttributes)
        
        return attributeString
        
        
    }
    
    func boldWordsInString(wordsToBold : [String], font: UIFont, boldFont: UIFont, isUnderlined: Bool? = false) -> NSAttributedString{
        
        let attributedString = NSMutableAttributedString(string: self, attributes:[NSAttributedString.Key.font:font])
        
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont]
        let underlineAttribute : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue): NSUnderlineStyle.single.rawValue
        ]
        
        for stringToBold in wordsToBold
        {
            attributedString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: stringToBold))
            
            if isUnderlined == true{
                attributedString.addAttributes(underlineAttribute, range: (self as NSString).range(of: stringToBold))
            }
        }
        
        return attributedString
    }
}

public extension String{
    
    static func generateRandomValue(length: Int) -> String{
        
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


public extension String{
    
    var decimalAmount: Decimal?{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr")
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.number(from: self)?.decimalValue
    }
}


public extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func call() {
        if isValid(regex: .phone) {
            if let url = URL(string: "telprompt://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}
