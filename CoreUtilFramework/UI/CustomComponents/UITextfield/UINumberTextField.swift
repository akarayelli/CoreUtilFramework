
import Foundation
import UIKit

class UINumberTextField:UIPaddingTextField{

    convenience init(){
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.keyboardType = UIKeyboardType.numberPad
        delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.keyboardType = UIKeyboardType.numberPad
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.keyboardType = UIKeyboardType.numberPad
        delegate = self
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "1234567890"
        let set = CharacterSet(charactersIn: allowedCharacters)
        let notAllowedCharacters = set.inverted
        let filtered = string.components(separatedBy: notAllowedCharacters).joined(separator: "")
        guard filtered == string else {
            return false
        }
        
        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
}
