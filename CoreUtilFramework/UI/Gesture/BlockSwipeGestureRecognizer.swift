

import UIKit

public class BlockSwipeGestureRecognizer: UISwipeGestureRecognizer {

    private var swipeAction: ((UISwipeGestureRecognizer) -> Void)?

    public  convenience init (numberOfTouchesRequired: Int = 1, swipeAction: ((UISwipeGestureRecognizer) -> Void)?) {
        self.init()
        self.numberOfTouchesRequired = numberOfTouchesRequired
        self.swipeAction = swipeAction
        self.addTarget(self, action: #selector(handleSwipe(swipe:)))
    }

    public  convenience init (numberOfTouchesRequired: Int = 1, direction: UISwipeGestureRecognizer.Direction, swipeAction: ((UISwipeGestureRecognizer) -> Void)?) {
        self.init()
        self.numberOfTouchesRequired = numberOfTouchesRequired
        self.direction = direction
        self.swipeAction = swipeAction
        self.addTarget(self, action: #selector(handleSwipe(swipe:)))
    }

    @objc func handleSwipe(swipe: UISwipeGestureRecognizer) {
        swipeAction?(swipe)
    }

}
