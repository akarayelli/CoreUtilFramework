

import Foundation

// MARK: - Format

public extension Date {
    
    init?(fromString string: String, format: String, timezoneIdentifier: String? = nil) {
        let formatter = SDateFormatter.sharedInstance
        formatter.dateFormat = format
        
        if let identifier = timezoneIdentifier{
            formatter.timeZone = TimeZone(identifier: identifier)
        }
        
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval: 0, since: date)
    }
    
    func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = SDateFormatter.sharedInstance
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self as Date)
    }
    
    func toString(format: String, timezoneIdentifier: String? = nil) -> String {
        let formatter = SDateFormatter.sharedInstance
        formatter.dateFormat = format
        
        if let identifier = timezoneIdentifier{
            formatter.timeZone = TimeZone(identifier: identifier)
        }
        
        return formatter.string(from: self as Date)
    }
    
    func toLocalizedString(format: String, localeIdentifier: String? = nil) -> String {
        
        let formatter = SDateFormatter.sharedInstance
        
        if let identifier = localeIdentifier{
            formatter.locale = Locale(identifier: identifier)
        }
        
        formatter.setLocalizedDateFormatFromTemplate(format)
        return formatter.string(from: self as Date)
    }
    

     static func formattedWith(_ date : String, currentFormat : String, formatToConvert : String, timezoneIdentifier: String? = nil) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = currentFormat
        
        if let identifier = timezoneIdentifier{
            formatter.timeZone = TimeZone(identifier: identifier)
        }
        
        let dateObject = formatter.date(from: date)
        formatter.dateFormat = formatToConvert
        return formatter.string(from: dateObject!)
    }
    
     func formattedWith(_ format : String, timezoneIdentifier: String? = nil ) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let identifier = timezoneIdentifier{
            formatter.timeZone = TimeZone(identifier: identifier)
        }
        
        return formatter.string(from: self)
    }
}

// MARK: - InBetweenDate

public extension Date {
    
     func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 86400)
        return diff
    }
    
     func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 3600)
        return diff
    }
    
     func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 60)
        return diff
    }
    
     func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }
}


public extension Date{
    
    
    /// Returns the amount of years from another date
     func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
     func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
     func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
     func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
     func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
     func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
     func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
     func offset(from date: Date, offsetType: DateOffsetType) -> Int {
        
        if(offsetType == .years){ return years(from: date) }
        if(offsetType == .months){ return months(from: date) }
        if(offsetType == .weeks){ return weeks(from: date) }
        if(offsetType == .days){ return days(from: date) }
        if(offsetType == .hours){ return hours(from: date) }
        if(offsetType == .minutes){ return minutes(from: date) }
        if(offsetType == .seconds){ return seconds(from: date) }
        
        return 0
    }
    
}

public enum DateOffsetType: Int {
    case years
    case months
    case weeks
    case days
    case hours
    case minutes
    case seconds
    
}



