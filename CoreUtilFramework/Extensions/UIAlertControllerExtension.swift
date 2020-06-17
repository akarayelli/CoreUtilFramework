
import Foundation
import UIKit

public extension UIAlertController {

    /// Provide onView parameter to make it compatible with iPad devices.
    static func show(title: String, message: String, cancelTitle: String = "OK", onView: UIView? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if onView != nil { alertController.popoverPresentationController?.sourceView = onView }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        UIApplication.shared.topViewController()?.present(alertController, animated: true, completion: nil)
    }

}
