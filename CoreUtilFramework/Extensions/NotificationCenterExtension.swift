
import Foundation

public extension NotificationCenter {

    func postNotification(name: String, object: AnyObject? = nil, userInfo: [NSObject : AnyObject]? = nil, queue: DispatchQueue) {
        queue.async {
            self.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
        }
    }

}
