

import UIKit

public class BlockTapGestureRecognizer: UITapGestureRecognizer {

    private var tapAction: ((UITapGestureRecognizer) -> Void)?

    public convenience init (numberOfTapsRequired: Int = 1, numberOfTouchesRequired: Int = 1, tapAction: ((UITapGestureRecognizer) -> Void)?) {
        self.init()
        self.numberOfTapsRequired = numberOfTapsRequired
        self.numberOfTouchesRequired = numberOfTouchesRequired
        self.tapAction = tapAction
        self.addTarget(self, action: #selector(handleTap(tap:)))
    }

    @objc func handleTap(tap: UITapGestureRecognizer) {
        tapAction?(tap)
    }

}
