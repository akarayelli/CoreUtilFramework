

import UIKit

public extension UIWebView{

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
