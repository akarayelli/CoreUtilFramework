
import Foundation

struct ApiError {
    var error: NSError?
    var message: String?
    
    var code : Int?
    
    init (){
    }
    
    init(message : String, error : NSError? = nil){
        self.message = message
        self.error = error ?? nil
        
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

struct ApiWarning {
    var message: String?
    
    var code : Int?
    
    var description: String {
        if let message = message {
            return message
        }
        return "ApiWarning"
    }
    
    init(message : String){
        self.message = message
    }
    
    init() {}
}


