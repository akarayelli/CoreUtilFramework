

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
