import Foundation

extension Float {
    var abs: Float {
        
        //return Foundation.fabs(self)
        return Swift.abs(self)
        
    }

    var sqrt: Float {
        return Foundation.sqrt(self)
    }

    var floor: Float {
        return Foundation.floor(self)
    }

    var ceil: Float {
        return Foundation.ceil(self)
    }

    var round: Float {
        return Foundation.round(self)
    }

    func clamp(_ min: Float, _ max: Float) -> Float {
        return Swift.max(min, Swift.min(max, self))
    }

    static func random(min: Float = 0, max: Float) -> Float {
        let diff = max - min
        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min
    }

    func distance(_ precision: Int = -1) -> String { // precision < 0: Auto
        var num = self
        var unit = "m"
        if num > 1000.0 {
            unit = "km"
            num /= 1000.0
        }
        if precision == -1 {
            if num == truncf(num) {
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
