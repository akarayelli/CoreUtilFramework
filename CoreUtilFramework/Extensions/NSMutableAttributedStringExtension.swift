

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import Cocoa
#endif

// MARK - Colors

public extension NSMutableAttributedString {

    static func setTextColor(text: String, color: SwiftyColor, afterOcurrence occurence: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setTextColor(color: color, afterOcurrence: occurence)
        return attrStr
    }

    static func setTextColor(text: String, color: SwiftyColor, forOccurences searchString: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setTextColor(color: color, forOccurences: searchString)
        return attrStr
    }

    func setTextColor(color: SwiftyColor, afterOcurrence occurence: String) {
        let range = NSRange(text: string, afterOccurence: occurence)
        if range.location != NSNotFound {
            setTextColor(value: color, range: range)
        }
    }

    func setTextColor(color: SwiftyColor, forOccurences searchString: String) {
        addAttributeForOccurence(searchString: searchString, value: color, funcAddingAttribute: setTextColor)
    }

}

// MARK - Strike

public extension NSMutableAttributedString {

    static func setTextStrike(text: String, afterOcurrence occurence: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setTextStrike(afterOcurrence: occurence)
        return attrStr
    }

    static func setTextStrike(text: String, forOccurences searchString: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setTextStrike(forOccurences: searchString)
        return attrStr
    }

    func setTextStrike(afterOcurrence occurence: String) {
        let range = NSRange(text: string, afterOccurence: occurence)
        if range.location != NSNotFound {
            setTextStrike(range: range)
        }
    }

    func setTextStrike(forOccurences searchString: String) {
        addAttributeForOccurence(searchString: searchString, funcAddingAttribute: setTextStrike)
    }

}

// MARK - Underline

public extension NSMutableAttributedString {

    static func setTextUnderline(text: String, afterOcurrence occurence: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setTextUnderline(afterOcurrence: occurence)
        return attrStr
    }

    static func setTextUnderline(text: String, forOccurences searchString: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setTextUnderline(forOccurences: searchString)
        return attrStr
    }

    func setTextUnderline(afterOcurrence occurence: String) {
        let range = NSRange(text: string, afterOccurence: occurence)
        if range.location != NSNotFound {
            setTextUnderline(range: range)
        }
    }

    func setTextUnderline(forOccurences searchString: String) {
        addAttributeForOccurence(searchString: searchString, funcAddingAttribute: setTextUnderline)
    }

}

// MARK - Private

fileprivate extension NSMutableAttributedString {

    func addAttributeForOccurence(searchString: String, value: Any = 1, funcAddingAttribute: ((_ value: Any, _ range: NSRange) -> Void)) {
        let inputLength = string.length
        let searchLength = searchString.length
        var range = NSRange(location: 0, length: length)
        while range.location != NSNotFound {
            range = (string as NSString).range(of: searchString, options: [], range: range)
            if range.location != NSNotFound {
                funcAddingAttribute(value, NSRange(location: range.location, length: searchLength))
                range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
            }
        }
    }

    func setTextColor(value: Any, range: NSRange) {
        addAttribute(NSAttributedString.Key.foregroundColor, value: value, range: range)
    }

    func setTextStrike(value: Any = 1, range: NSRange) {
        addAttribute(NSAttributedString.Key.strikethroughStyle, value: value, range: range)
    }

    func setTextUnderline(value: Any = 1, range: NSRange) {
        addAttribute(NSAttributedString.Key.underlineStyle, value: value, range: range)
    }
}
