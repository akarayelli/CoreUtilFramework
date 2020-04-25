

import UIKit

public extension UIDevice {

    class func idForVendor() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    class func systemName() -> String {
        return UIDevice.current.systemName
    }

    class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }

    class func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }

    class func deviceName() -> String {
        return UIDevice.current.name
    }

    class func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }

    class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

}

// MARK: - Version

public extension UIDevice {

    class func isVersion(_ version: Float) -> Bool {
        return systemFloatVersion() >= version && systemFloatVersion() < (version + 1.0)
    }

    class func isVersionOrLater(_ version: Float) -> Bool {
        return systemFloatVersion() >= version
    }

    class func isVersionOrEarlier(_ version: Float) -> Bool {
        return systemFloatVersion() < (version + 1.0)
    }

}

public extension UIDevice {

    func forceRotation(_ orientation: UIInterfaceOrientation) {
        setValue(orientation.rawValue, forKey: "orientation")
    }

    class func forceRotation(_ orientation: UIInterfaceOrientation) {
        UIDevice.current.forceRotation(orientation)
    }

}




public extension UIDevice {
    
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneXR = "iPhone XR"
        case iPhoneX_iPhoneXS = "iPhone X,iPhoneXS"
        case iPhoneXSMax = "iPhoneXS Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhoneXR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX_iPhoneXS
        case 2688:
            return .iPhoneXSMax
        default:
            return .unknown
        }
    }
}
