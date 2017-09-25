
import Foundation
import UIKit

public extension UISwitch {

    public func toggle(animated: Bool = true) {
        self.setOn(!self.isOn, animated: animated)
    }

}
