

import UIKit

public extension UIScreen {

    static func screenOrientation() -> UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    static func screenSize() -> CGSize {
        return CGSize(width: screenWidth, height: screenHeight)
    }

    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    static var screenHeightWithoutStatusBar: CGFloat {
        
        
        return screenOrientation().isPortrait ? UIScreen.main.bounds.size.height - screenStatusBarHeight :
            UIScreen.main.bounds.size.width - screenStatusBarHeight
    }

}
