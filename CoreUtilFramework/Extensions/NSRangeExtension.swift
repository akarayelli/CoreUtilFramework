

import Foundation

public extension NSRange {

    public init(text: String, afterOccurence occurence: String) {
        self = (text as NSString).range(of: occurence, options: [])
        if location != NSNotFound {
            location += 1
            length = text.length - location
        }
    }

    public init(textToFind: String, in text: String) {
        self = (text as NSString).range(of: textToFind, options: [])
    }

}
