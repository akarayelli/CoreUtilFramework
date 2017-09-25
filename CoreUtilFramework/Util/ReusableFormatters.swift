

import Foundation

public struct SDateFormatter {

    public static let sharedInstance = DateFormatter()
    private init() {}

}

public struct SNumberFormatter {

    public static let sharedInstance = NumberFormatter()
    private init() {}

}

public struct SByteCountFormatter {

    public static let sharedInstance = ByteCountFormatter()
    private init() {}

}

public struct SDateComponentsFormatter {

    public static let sharedInstance = DateComponentsFormatter()
    private init() {}

}

public struct SDateIntervalFormatter {

    public static let sharedInstance = DateIntervalFormatter()
    private init() {}

}

public struct SEnergyFormatter {

    public static let sharedInstance = EnergyFormatter()
    private init() {}

}

public struct SMassFormatter {

    public static let sharedInstance = MassFormatter()
    private init() {}

}

public struct SLengthFormatter {

    public static let sharedInstance = LengthFormatter()
    private init() {}

}
