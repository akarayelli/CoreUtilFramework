

import Foundation

// MARK: - Format

public extension Date {

    public init?(fromString string: String, format: String) {
        let formatter = SDateFormatter.sharedInstance
        formatter.dateFormat = format
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval: 0, since: date)
    }

    public func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = SDateFormatter.sharedInstance
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self as Date)
    }

    public func toString(format: String) -> String {
        let formatter = SDateFormatter.sharedInstance
        formatter.dateFormat = format
        return formatter.string(from: self as Date)
    }
    
    
    func formattedWith(_ date : String, currentFormat : String, formatToConvert : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = currentFormat
        let dateObject = formatter.date(from: date)
        formatter.dateFormat = formatToConvert
        return formatter.string(from: dateObject!)
    }
    
    func formattedWith(_ format : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }


}

// MARK: - InBetweenDate

public extension Date {

    public func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 86400)
        return diff
    }

    public func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 3600)
        return diff
    }

    public func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 60)
        return diff
    }

    public func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }

}
