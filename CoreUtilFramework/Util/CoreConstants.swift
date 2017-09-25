
import Foundation


#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    public  typealias SwiftyColor = UIColor
#if !os(watchOS)
    public typealias SwiftyView = UIView
#endif
#elseif os(OSX)
    import Cocoa
    public typealias SwiftyColor = NSColor
    public typealias SwiftyView = NSView
#endif
