
import Foundation

public struct ApiError {
    public var error: NSError?
    public var message: String?
    public var code : String?
    
    public init (){
    }
    
    public init(message : String, error : NSError? = nil, code: String){
        self.message = message
        self.error = error ?? nil
        self.code = code
    }
    
    public var description: String {
        if let error = error {
            return error.logicalErrorDescription
        }
        else if let message = message {
            return message
        }
        return "ApiError"
    }

    public func messageWithErrorCode(messageTemplate: String = "%@ (%@)") -> String? {
        guard let message = message, let code = code else { return nil }
        return String(format: messageTemplate, message, code)
    }
}

public struct ApiWarning {
    public var message: String?
    
    public var code : Int?
    
    public var description: String {
        if let message = message {
            return message
        }
        return "ApiWarning"
    }
    
    public init(message : String){
        self.message = message
    }
    
    public init() {}
    
    public func messageWithCode(messageTemplate: String = "%@ (%@)") -> String? {
        guard let message = message, let code = code else { return nil }
        return String(format: messageTemplate, message, code)
    }
}


