import Foundation

extension Date {
    public func isToday(calendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> Bool {
        return calendar.isDateInToday(self as NSDate)
    }

    public func isYesterday(calendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> Bool {
        return calendar.isDateInYesterday(self as NSDate)
    }

    public func isTomorrow(calendar calendar: NSCalendar = NSCalendar.currentCalendar())-> Bool {
        return calendar.isDateInTomorrow(self as NSDate)
    }

    public func isWeekend(calendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> Bool {
        return calendar.isDateInWeekend(self as NSDate)
    }

    public func isSameDay(date: Date, calendar: NSCalendar = NSCalendar.currentCalendar()) -> Bool {
        return calendar.isDate(self as NSDate, inSameDayAsDate: date as NSDate)
    }

    public func startOfDay(calendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> Date {
        return calendar.startOfDayForDate(self as NSDate) as Date
    }

    public func components(calendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> DateComponents {
        return calendar.components([.Era, .Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond, .Weekday, .WeekdayOrdinal, .Quarter, .WeekOfMonth, .WeekOfYear, .YearForWeekOfYear], fromDate: self as NSDate) as DateComponents
    }
}
