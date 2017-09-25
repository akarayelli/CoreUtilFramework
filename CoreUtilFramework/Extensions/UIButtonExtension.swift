//
//  UIButtonExtension.swift
//  TTPrime
//
//  Created on 10/02/2017.
//  Copyright © 2017 Ratel Bilişim Hizmetleri. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
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
    
}


