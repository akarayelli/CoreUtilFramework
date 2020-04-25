import UIKit


public extension UIStoryboard {

    static var main: UIStoryboard {
        let bundle = Bundle.main
        guard let storyboardName = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            fatalError("No main storyboard set in your app.")
        }
        return  UIStoryboard(name: storyboardName, bundle: bundle)
    }

}
