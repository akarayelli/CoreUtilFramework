import Foundation

public protocol Then {}

public extension Then {

    /// Makes it available to set properties with closures.
    ///
    ///     let label = UILabel().then {
    ///         $0.textAlignment = .Center
    ///         $0.textColor = UIColor.blackColor()
    ///         $0.text = "Hello, World!"
    ///     }
    func then(block: (inout (Self)) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }

}

extension NSObject: Then {}
