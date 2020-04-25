

import Foundation
import UIKit

public typealias UIButtonTargetClosure = () -> Void

open class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}


public extension UIButton {
    
    var isListStyle : Bool {
        set {
            if(newValue){
                self.titleLabel?.numberOfLines = 2
                self.titleLabel?.adjustsFontSizeToFitWidth = true
                self.titleLabel?.minimumScaleFactor = 8.0 / UIFont.labelFontSize
                self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 35.0)
                self.titleLabel?.textAlignment = NSTextAlignment.center
            }
        }
        
        get {
            return (self.titleLabel?.numberOfLines == 2 && (self.titleLabel?.adjustsFontSizeToFitWidth)!)
        }
    }
    
    
     func setBackgroundColor(color: UIColor, forState: UIControl.State){
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        self.setBackgroundImage(colorImage, for: forState)
    }
}




public extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure()
    }
}


