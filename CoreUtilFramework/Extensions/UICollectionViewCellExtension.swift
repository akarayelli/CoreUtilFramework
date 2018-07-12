//
//  UICollectionViewCellExtension.swift
//  TTPrime
//
//  Created on 11/02/2017.
//  Copyright © 2017 Ratel Bilişim Hizmetleri. All rights reserved.
//

import Foundation
import UIKit


public extension UICollectionViewCell{
    
    @IBInspectable public var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable public var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable public var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    
}
