
import Foundation
import UIKit

open class UIPaddingTextField:UIBaseTextField{
    @IBInspectable var leftPadding:CGFloat=0
    @IBInspectable var rightPadding:CGFloat=0
    @IBInspectable var topPadding:CGFloat=0
    @IBInspectable var bottomPadding:CGFloat=0

    
    public convenience init(){
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        delegate = self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        delegate = self
    }
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let margin = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        let content = bounds.inset(by: margin)
        return super.textRect(forBounds: content)
        
        //Swift 4.0 deprecated
        //return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let margin = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        let content = bounds.inset(by: margin)
        return super.editingRect(forBounds: content)
        
        //Swift 4.0 deprecated
        //return super.editingRect(forBounds: UIEdgeInsetsInsetRect(bounds,  UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)))
    }
    
    
}
