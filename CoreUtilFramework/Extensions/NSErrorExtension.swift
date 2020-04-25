
import ObjectiveC
import Foundation


private var errorKey: UInt8 = 0

public extension NSError {
    
    var logicalErrorDescription:String!{
        get {
            if let message = (objc_getAssociatedObject(self, &errorKey) as? String){
                return message
            }
            return "UnexpectedError".localized
        }
        set(newValue) {
            objc_setAssociatedObject(self, &errorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


public extension NSError {
    convenience init(domain: String? = nil, status: HTTPStatus, message: String? = nil) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message ?? status.description]
        self.init(domain: domain, code: status.code, userInfo: userInfo)
    }
    
    convenience init(domain: String? = nil, code: Int = -999, message: String) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
}
