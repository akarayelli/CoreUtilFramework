

import Foundation

public class BlockNotification {

    public let name: String
    private var object: AnyObject?
    private let closure: ((NSNotification) -> Void)

    // MARK - Initializers

    public init(name: String, closure: @escaping (NSNotification) -> ()) {
        self.name = name
        self.closure = closure
        self.start()
    }

    public convenience init(name: String, object: AnyObject,
                            closure: @escaping (NSNotification) -> ()) {
        self.init(name: name, closure: closure)
        self.object = object
    }

    deinit {
        stop()
    }

    // MARK -

    public  func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)), name: NSNotification.Name(rawValue: name), object: object)
    }

    public  func stop() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK - Action

    @objc dynamic func handleNotification(notification: NSNotification) {
        closure(notification)
    }

}
