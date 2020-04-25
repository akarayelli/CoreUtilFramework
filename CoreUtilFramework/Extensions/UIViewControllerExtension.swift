
import UIKit

// MARK: - Helpers

public extension UIViewController {

    func getIdentifierName() -> String{
        return String(describing: type(of: self))
    }
    
    func deletePreviousViewControllers(animated: Bool = false) {
        navigationController?.setViewControllers([self], animated: animated)
    }

}

// MARK: - NavigationBar

public extension UIViewController {

    func setupBackButton(hidden: Bool = false, title: String = "", backIndicatorImage: UIImage? = nil, tintColor: UIColor? = UIColor.white) {
        navigationItem.hidesBackButton = hidden
        if !hidden {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)

            if let unwrappedColor = tintColor {
                navigationItem.backBarButtonItem?.tintColor = unwrappedColor
                navigationController?.navigationBar.tintColor = unwrappedColor
            }

            if let unwrappedImage = backIndicatorImage {
                navigationController?.navigationBar.backIndicatorImage = unwrappedImage
                navigationController?.navigationBar.backIndicatorTransitionMaskImage = unwrappedImage
            }
        }
    }

    func setupBar(leftView: UIView) {
        let leftBarButtonItem = UIBarButtonItem(customView: leftView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    func setupBar(rightView: UIView) {
        let rightBarButtonItem = UIBarButtonItem(customView: rightView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    


}
