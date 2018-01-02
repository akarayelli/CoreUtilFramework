

import UIKit

public class BlockPanGestureRecognizer: UIPanGestureRecognizer {

    private var panAction: ((UIPanGestureRecognizer) -> Void)?

    public  convenience init (minimumNumberOfTouches: Int = 1, panAction: ((UIPanGestureRecognizer) -> Void)?) {
        self.init()
        self.minimumNumberOfTouches = minimumNumberOfTouches
        self.panAction = panAction
        self.addTarget(self, action: #selector(handlePan(pan:)))
    }

    @objc func handlePan(pan: UIPanGestureRecognizer) {
        panAction?(pan)
    }

}
