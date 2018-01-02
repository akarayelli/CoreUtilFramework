

import UIKit

public class BlockLongPressGestureRecognizer: UILongPressGestureRecognizer {

    private var longPressAction: ((UILongPressGestureRecognizer) -> Void)?

    public  convenience init (numberOfTapsRequired: Int = 0,
                              numberOfTouchesRequired: Int = 1,
                              minimumPressDuration: CFTimeInterval = 0.5,
                              longPress: ((UILongPressGestureRecognizer) -> Void)?) {
        self.init()
        self.numberOfTapsRequired = numberOfTapsRequired
        self.numberOfTouchesRequired = numberOfTouchesRequired
        self.minimumPressDuration = minimumPressDuration
        self.longPressAction = longPress
        self.addTarget(self, action: #selector(handleLongPress(longPress:)))
    }

    @objc func handleLongPress(longPress: UILongPressGestureRecognizer) {
        longPressAction?(longPress)
    }

}
