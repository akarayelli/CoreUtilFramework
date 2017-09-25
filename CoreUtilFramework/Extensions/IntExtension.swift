

import Foundation

public extension Int {

    public var isEven: Bool { return (self % 2 == 0) }
    public var isOdd: Bool { return (self % 2 != 0) }
    public var isPositive: Bool { return (self > 0) }
    public var isNegative: Bool { return (self < 0) }
    public var range: Range<Int> { return 0..<self }

    public var digits: Int {
        if self == 0 {
            return 1
        } else if Int(fabs(Double(self))) <= LONG_MAX {
            return Int(log10(fabs(Double(self)))) + 1
        } else {
            return -1
        }
    }
    
    
    public static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }

}
