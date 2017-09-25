
import Foundation
import UIKit

class UIPaddingTextField:UIBaseTextField{
    @IBInspectable var leftPadding:CGFloat=0
    @IBInspectable var rightPadding:CGFloat=0
    @IBInspectable var topPadding:CGFloat=0
    @IBInspectable var bottomPadding:CGFloat=0

    
    convenience init(){
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        delegate = self
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(topPadding, leftPadding, bottomPadding, rightPadding)))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: UIEdgeInsetsInsetRect(bounds,  UIEdgeInsetsMake(topPadding, leftPadding, bottomPadding, rightPadding)))
    }
    
    
}
