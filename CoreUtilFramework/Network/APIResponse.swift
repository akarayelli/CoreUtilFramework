
import Foundation

public struct ApiError {
    var error: NSError?
    var message: String?
    var code : String?
    
    public init (){
    }
    
    public init(message : String, error : NSError? = nil, code: String){
        self.message = message
        self.error = error ?? nil
        self.code = code
    }
    
    var description: String {
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
    var message: String?
    
    var code : Int?
    
    var description: String {
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


