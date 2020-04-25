

import Foundation

public extension NSObject {

    var className: String {
        return type(of: self).className
    }

    static var className: String {
        return stringFromClass(aClass: self)
    }

}

func stringFromClass(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
