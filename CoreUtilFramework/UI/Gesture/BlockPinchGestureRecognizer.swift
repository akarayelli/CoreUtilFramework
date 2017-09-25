

import UIKit

public class BlockPinchGestureRecognizer: UIPinchGestureRecognizer {

    private var pinchAction: ((UIPinchGestureRecognizer) -> Void)?

    public  convenience init (pinchAction: ((UIPinchGestureRecognizer) -> Void)?) {
        self.init()
        self.pinchAction = pinchAction
        self.addTarget(self, action: #selector(handlePinch(pinch:)))
    }

    func handlePinch(pinch: UIPinchGestureRecognizer) {
        pinchAction?(pinch)
    }

}
