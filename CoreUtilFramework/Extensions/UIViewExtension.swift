

import Foundation
import UIKit

// MARK - Localizables

public extension UIView {
    
    // swiftlint:disable:next cyclomatic_complexity
    func convertLocalizables() {
        if subviews.count == 0 {
            return
        }
        
        for aSubview: UIView in subviews {
            if let aLabel = aSubview as? UILabel {
                if let text = aLabel.text {
                    aLabel.text = NSLocalizedString(text, comment: "")
                }
            } else if let aTextField = aSubview as? UITextField {
                if let text = aTextField.text {
                    aTextField.text = NSLocalizedString(text, comment: "")
                }
                if let placeholder = aTextField.placeholder {
                    aTextField.placeholder = NSLocalizedString(placeholder, comment: "")
                }
            } else if let aTextView = aSubview as? UITextView {
                if let text = aTextView.text {
                    aTextView.text = NSLocalizedString(text, comment: "")
                }
            } else if let aButton = aSubview as?  UIButton {
                if let title = aButton.title(for: []) {
                    aButton.setTitle(NSLocalizedString(title, comment: ""), for: [])
                }
            } else {
                aSubview.convertLocalizables()
            }
        }
    }
    
}

// MARK: - Nib

public extension UIView {
    
    class func fromNib<T: UIView>(nibNameOrNil: String? = nil) -> T {
        let v: T? = fromNib(nibNameOrNil: nibNameOrNil)
        return v!
    }
    
    class func fromNib<T: UIView>(nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = T.className
        }
        
        guard let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil) else {
            return nil
        }
        
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
}


public extension UIView {
    func getAllSubviewsRecursively() -> [AnyObject] {
        var allSubviews: [AnyObject] = []
        
        for subview in self.subviews {
            allSubviews.append(subview)
            allSubviews = allSubviews + subview.getAllSubviewsRecursively()
        }
        
        return allSubviews
    }
}

public extension UIView {
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var xPos: CGFloat {
        return self.frame.origin.x
    }
    
    var yPos: CGFloat {
        return self.frame.origin.y
    }
    
    var yBottom: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
}

public extension UIView{
    
    func shake(duration: CFTimeInterval) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0 ]
        layer.add(animation, forKey: "customShakeAnimation")
        
    }
    
    func textDropShadow(radius: CGFloat = 2.0, opacity: Float = 0.2, offsetWidth: Int = 1, offsetHeight: Int = 2) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        
    }
    
}


public extension UIView {
    func createDottedLine(width: CGFloat, color: CGColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [2,3]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    
    func addShadow(radius: CGFloat = 5, offset: CGSize = CGSize(width: 0, height: 3), opacity: Float = 0.5){
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func removeShadow(){
        layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = corners
        } else {
            self.layer.cornerRadius = radius
        }
    }
}
