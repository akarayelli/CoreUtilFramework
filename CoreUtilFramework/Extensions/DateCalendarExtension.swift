
//  Inspired from https://github.com/datejs/Datejs
//

import Foundation

// MARK: - Initializer

public extension Date {

    // swiftlint:disable:next function_parameter_count
     init(year: Int, month: Int, day: Int, hours: Int, minutes: Int, seconds: Double) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hours
        components.minute = minutes
        components.second = Int(seconds)
        components.nanosecond = Int((seconds - floor(seconds)) * 1_000_000_000)
        let interval = NSCalendar.current.date(from: components)?.timeIntervalSinceReferenceDate ?? 0
        self.init(timeIntervalSinceReferenceDate: interval)
    }

     init(year: Int, month: Int, day: Int) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        let interval = NSCalendar.current.date(from: components)?.timeIntervalSinceReferenceDate ?? 0
        self.init(timeIntervalSinceReferenceDate: interval)
    }

     init(hours: Int, minutes: Int, seconds: Double) {
        var components = DateComponents()
        components.hour = hours
        components.minute = minutes
        components.second = Int(seconds)
        components.nanosecond = Int((seconds - floor(seconds)) * 1_000_000_000)
        let interval = NSCalendar.current.date(from: components)?.timeIntervalSinceReferenceDate ?? 0
        self.init(timeIntervalSinceReferenceDate: interval)
    }

    static func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        return Date(year: year, month: month, day: day)
    }

    static func time(_ hours: Int, _ minutes: Int, _ seconds: Double) -> Date {
        return Date(hours: hours, minutes: minutes, seconds: seconds)
    }

}

// MARK: - Extracting date

public extension Date {

    var date: Date {
        return Date(year: self.year, month: self.month, day: self.day)
    }

    static var today: Date {
        return Date().date
    }

}


// MARK: - Setter and getters for date components

public extension Date {

    var year: Int { return self.components(units: [Calendar.Component.year]).year ?? -1 }
    var month: Int { return self.components(units: [Calendar.Component.month]).month ?? -1 }
    var day: Int { return self.components(units: [Calendar.Component.day]).day ?? -1 }
    var hours: Int { return self.components(units: [Calendar.Component.hour]).hour ?? -1 }
    var minutes: Int { return self.components(units: [Calendar.Component.minute]).minute ?? -1 }
    var seconds: Double {
        let components = self.components(units: [.second, .nanosecond])
        return Double(components.second ?? -1) + Double(components.nanosecond ?? -1) / 1_000_000_000
    }
    var weekday: Int { return self.components(units: [Calendar.Component.weekday]).weekday ?? -1}

    func with(year: Int) -> Date {
        return Date(year: year, month: month, day: day, hours: hours, minutes: minutes, seconds: seconds)
    }

    func with(month: Int) -> Date {
        return Date(year: year, month: month, day: day, hours: hours, minutes: minutes, seconds: seconds)
    }

    func with(day: Int) -> Date {
        return Date(year: year, month: month, day: day, hours: hours, minutes: minutes, seconds: seconds)
    }

    func with(hours: Int) -> Date {
        return Date(year: year, month: month, day: day, hours: hours, minutes: minutes, seconds: seconds)
    }

    func with(minutes: Int) -> Date {
        return Date(year: year, month: month, day: day, hours: hours, minutes: minutes, seconds: seconds)
    }

    func with(seconds: Double) -> Date {
        return Date(year: year, month: month, day: day, hours: hours, minutes: minutes, seconds: seconds)
    }

    func with(weekday: Int) -> Date? {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.year, .month, .day, .weekday], from: self)
        guard let day = components.day, let componentWeekday = components.weekday else {
            return nil
        }
        components.day = day + (weekday - componentWeekday)
        return calendar.date(from: components)
    }

    private func components(units: Set<Calendar.Component>) -> DateComponents {
        return NSCalendar.current.dateComponents(units, from: self)
    }

}


// MARK: - Relative datetime

public extension IntegerLiteralType {

    var years: DateTimeDelta { return DateTimeDelta(self, .year) }
    var months: DateTimeDelta { return DateTimeDelta(self, .month) }
    var days: DateTimeDelta { return DateTimeDelta(self, .day) }

    var hours: DateTimeDelta { return DateTimeDelta(self, .hour) }
    var minutes: DateTimeDelta { return DateTimeDelta(self, .minute)  }
    var seconds: DateTimeDelta { return DateTimeDelta(self, .second) }

    var year: DateTimeDelta { return self.years }
    var month: DateTimeDelta { return self.months }
    var day: DateTimeDelta { return self.days }

    var hour: DateTimeDelta { return self.hours }
    var minute: DateTimeDelta { return self.minutes }
    var second: DateTimeDelta { return self.seconds }

}

public struct DateTimeDelta {

    public var value: TimeInterval
    public var unit: NSCalendar.Unit

    public init(_ value: TimeInterval, _ unit: NSCalendar.Unit) {
        self.value = value
        self.unit = unit
    }

    public init(_ value: IntegerLiteralType, _ unit: NSCalendar.Unit) {
        self.init(TimeInterval(value), unit)
    }

    private var negativeDelta: DateTimeDelta {
        return type(of: self).init(-self.value, self.unit)
    }

    public func after(_ date: Date) -> Date {
        switch self.unit {
        case NSCalendar.Unit.year: return date.with(year: date.year + Int(self.value))
        case NSCalendar.Unit.month: return date.with(month: date.month + Int(self.value))
        case NSCalendar.Unit.day: return date.with(day: date.day + Int(self.value))
        case NSCalendar.Unit.hour: return date.with(hours: date.hours + Int(self.value))
        case NSCalendar.Unit.minute: return date.with(minutes: date.minutes + Int(self.value))
        case NSCalendar.Unit.second: return date.with(seconds: date.seconds + self.value)
        default: return date
        }
    }

    public func before(_ date: Date) -> Date {
        return self.negativeDelta.after(date)
    }

    public var fromNow: Date {
        return self.after(Date())
    }

    public var ago: Date {
        return self.negativeDelta.fromNow
    }

}

func + (date: Date, delta: DateTimeDelta) -> Date { return delta.after(date) }
func + (delta: DateTimeDelta, date: Date) -> Date { return delta.after(date) }
func - (date: Date, delta: DateTimeDelta) -> Date { return delta.before(date) }

// MARK: - Calendar

public extension Date {

    static var january: Date { return Date.today.with(month: 1).with(day: 1) }
    static var february: Date { return Date.today.with(month: 2).with(day: 1) }
    static var march: Date { return Date.today.with(month: 3).with(day: 1) }
    static var april: Date { return Date.today.with(month: 4).with(day: 1) }
    static var may: Date { return Date.today.with(month: 5).with(day: 1) }
    static var june: Date { return Date.today.with(month: 6).with(day: 1) }
    static var july: Date { return Date.today.with(month: 7).with(day: 1) }
    static var august: Date { return Date.today.with(month: 8).with(day: 1) }
    static var september: Date { return Date.today.with(month: 9).with(day: 1) }
    static var october: Date { return Date.today.with(month: 10).with(day: 1) }
    static var november: Date { return Date.today.with(month: 11).with(day: 1) }
    static var december: Date { return Date.today.with(month: 12).with(day: 1) }

    var first: CalendarDelta { return self.calendarDelta(ordinal: 0) }
    var second: CalendarDelta { return self.calendarDelta(ordinal: 1) }
    var third: CalendarDelta { return self.calendarDelta(ordinal: 2) }
    var fourth: CalendarDelta { return self.calendarDelta(ordinal: 3) }
    var fifth: CalendarDelta { return self.calendarDelta(ordinal: 4) }
    var last: CalendarDelta { return self.calendarDelta(ordinal: -1) }

    private func calendarDelta(ordinal: Int) -> CalendarDelta {
        return CalendarDelta(date: self, ordinal: ordinal)
    }

    static var sunday: Date? { return Date.today.with(weekday: 1) }
    static var monday: Date? { return Date.today.with(weekday: 2) }
    static var tuesday: Date? { return Date.today.with(weekday: 3) }
    static var wednesday: Date? { return Date.today.with(weekday: 4) }
    static var thursday: Date? { return Date.today.with(weekday: 5) }
    static var friday: Date? { return Date.today.with(weekday: 6) }
    static var saturday: Date? { return Date.today.with(weekday: 7) }

}

public struct CalendarDelta {

    var date: Date

    /// `0` for first and `-1` for last
    var ordinal: Int

    var sunday: Date? { return self.weekday(1) }
    var monday: Date? { return self.weekday(2) }
    var tuesday: Date? { return self.weekday(3) }
    var wednesday: Date? { return self.weekday(4) }
    var thursday: Date? { return self.weekday(5) }
    var friday: Date? { return self.weekday(6) }
    var saturday: Date? { return self.weekday(7) }

    private func weekday(_ weekday: Int) -> Date? {
        if self.ordinal == -1 {
            for i in (1...5).reversed() {
                if let date = CalendarDelta(date: self.date, ordinal: i).weekday(weekday) {
                    return date
                }
            }
            return nil
        }
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.year, .month, .day, .weekday], from: self.date)
        let ordinal = (weekday >= components.weekday ?? -1) ? self.ordinal : self.ordinal + 1
        components.day = (components.day ?? -1) + (weekday + 7 * ordinal - (components.weekday ?? -1))
        if let date = calendar.date(from: components), date.month == components.month {
            return date
        }
        return nil
    }

}
