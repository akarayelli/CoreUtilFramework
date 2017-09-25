

import Foundation
import UIKit

#if !os(watchOS)
public extension NSLayoutConstraint {

    public func apply(multiplier: CGFloat, toView: SwiftyView) {
        switch firstAttribute {
        case .width:
            constant = toView.bounds.width * multiplier
        case .height:
            constant = toView.bounds.height * multiplier
        default:
            break
        }
    }

}
#endif
