

import Foundation

public struct SDateFormatter {

    static let sharedInstance = DateFormatter()
    private init() {}

}

public struct SNumberFormatter {

    static let sharedInstance = NumberFormatter()
    private init() {}

}

public struct SByteCountFormatter {

    static let sharedInstance = ByteCountFormatter()
    private init() {}

}

public struct SDateComponentsFormatter {

    static let sharedInstance = DateComponentsFormatter()
    private init() {}

}

public struct SDateIntervalFormatter {

    static let sharedInstance = DateIntervalFormatter()
    private init() {}

}

public struct SEnergyFormatter {

    static let sharedInstance = EnergyFormatter()
    private init() {}

}

public struct SMassFormatter {

    static let sharedInstance = MassFormatter()
    private init() {}

}

public struct SLengthFormatter {

    static let sharedInstance = LengthFormatter()
    private init() {}

}
