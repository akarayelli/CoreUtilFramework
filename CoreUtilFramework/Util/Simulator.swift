
import Foundation

public struct Simulator {

    static var isRunning: Bool = {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }()
}
