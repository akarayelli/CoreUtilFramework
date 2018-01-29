
import Foundation

public struct ApiError {
    public var error: NSError?
    public var message: String?
    
    public var code : Int?
    
    public init (){
    }
    
    public init(message : String, error : NSError? = nil){
        self.message = message
        self.error = error ?? nil
        
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
}


