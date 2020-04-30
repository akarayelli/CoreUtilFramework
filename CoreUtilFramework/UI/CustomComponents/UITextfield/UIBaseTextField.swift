
/**
 * This class created in order to handle all basic TextField Operations and connect them to appropriate TextFields in xib or storyboard
 *@Inspectable Parameters used for this purpose
 *
 *
 */
import Foundation
import UIKit


open class UIBaseTextField: UITextField,UITextFieldDelegate {
    @IBInspectable public var isPerformingAction:Bool=false
    @IBInspectable public var charLimit: Int = 0
    
    
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
    
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return self.isPerformingAction;
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Bypass "Backspace" was pressed
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {
            return true
        }
        
        
        //eğer charLimit 0 ise, herhangi bir kontrol yapılmayacak bu alanla ilgili, 0 dan büyükse kontrol yapılacak.
        if(self.charLimit > 0 &&  self.charLimit == textField.text?.count){
            return false
        }
        
        return true
    }
    
}
