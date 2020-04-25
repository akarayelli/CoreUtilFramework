

import Foundation
#if os(OSX)
    import Cocoa
#else
    import UIKit
#endif

// MARK: Init

public extension SwiftyColor {

    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

}

// MARK: - Components

#if !os(OSX)
public extension SwiftyColor {

    var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }

    var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }

    var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }

    var alpha: CGFloat {
        var alpha: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha
    }

}
#endif

// MARK: - Brightness

public extension SwiftyColor {

    func lighter(amount: CGFloat = 0.25) -> SwiftyColor {
        return hueColorWithBrightnessAmount(amount: 1 + amount)
    }

    func darker(amount: CGFloat = 0.25) -> SwiftyColor {
        return hueColorWithBrightnessAmount(amount: 1 - amount)
    }

    private func hueColorWithBrightnessAmount(amount: CGFloat) -> SwiftyColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        #if os (iOS) || os (tvOS) || os (watchOS)
            if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
                return SwiftyColor(hue: hue, saturation: saturation,
                                   brightness: brightness * amount,
                                   alpha: alpha)
            }
            return self
        #else
            getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            return SwiftyColor(hue: hue, saturation: saturation,
                               brightness: brightness * amount,
                               alpha: alpha)
        #endif
    }

}
