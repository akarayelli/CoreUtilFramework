//
//  UIScrollViewExtension.swift
//  TTPrime
//
//  Created on 12/03/2017.
//  Copyright © 2017 Ratel Bilişim Hizmetleri. All rights reserved.
//

import UIKit

extension UIWebView{

    @IBInspectable var fitContent:Bool{
        set {
            if(newValue){
                
                self.scrollView.isScrollEnabled = false;
                self.scrollView.bounces = false;
                self.scrollView.minimumZoomScale = 1.0
                self.scrollView.maximumZoomScale = 1.0
            }
        }
        
        get {
            return (self.scrollView.isScrollEnabled == false && self.scrollView.bounces == false && self.scrollView.minimumZoomScale == 1.0 && self.scrollView.maximumZoomScale == 1.0)
        }
    }

}
