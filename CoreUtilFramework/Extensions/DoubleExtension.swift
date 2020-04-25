

import Foundation

public extension Double {
    var millisecond: TimeInterval { return self / 1000 }
    var milliseconds: TimeInterval { return self / 1000 }
    // swiftlint:disable:next variable_name
    var ms: TimeInterval { return self / 1000 }

    var second: TimeInterval { return self }
    var seconds: TimeInterval { return self }

    var minute: TimeInterval { return self * 60 }
    var minutes: TimeInterval { return self * 60 }

    var hour: TimeInterval { return self * 3600 }
    var hours: TimeInterval { return self * 3600 }

    var day: TimeInterval { return self * 3600 * 24 }
    var days: TimeInterval { return self * 3600 * 24 }
    
    
    var abs: Double {
        return Foundation.fabs(self)
    }
    
    var sqrt: Double {
        return Foundation.sqrt(self)
    }
    
    var floor: Double {
        return Foundation.floor(self)
    }
    
    var ceil: Double {
        return Foundation.ceil(self)
    }
    
    var round: Double {
        return Foundation.round(self)
    }
    
    func clamp(_ min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    static func random(min: Double = 0, max: Double) -> Double {
        let diff = max - min
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min
    }

    
    func distance(_ precision: Int = -1, meter: String = "m", kilometer: String = "km") -> String { // precision < 0: Auto
        var num = self
        var unit = meter
        if num > 1000.0 {
            unit = kilometer
            num /= 1000.0
        }
        if precision == -1 {
            if num == trunc(num) {
                return String(format: "%.0f%@", num, unit)
            } else {
                return String(format: "%.1f%@", num, unit)
            }
        } else {
            let format = "%.\(precision)f%@"
            return String(format: format, num, unit)
        }
    }
    
    
}
