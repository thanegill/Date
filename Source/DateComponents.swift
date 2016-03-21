import Foundation

public struct DateComponents {
    public let era: Int?
    public let year: Int?
    public let month: Int?
    public let day: Int?
    public let hour: Int?
    public let minute: Int?
    public let second: Int?
    public let nanosecond: Int?
    public let weekday: Int?
    public let weekdayOrdinal: Int?
    public let quarter: Int?
    public let weekOfMonth: Int?
    public let weekOfYear: Int?
    public let yearForWeekOfYear: Int?

    public init(
        era: Int? = nil,
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        weekday: Int? = nil,
        weekdayOrdinal: Int? = nil,
        quarter: Int? = nil,
        weekOfMonth: Int? = nil,
        weekOfYear: Int? = nil,
        yearForWeekOfYear: Int? = nil
    ) {
        self.era = era
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
        self.nanosecond = nanosecond
        self.weekday = weekday
        self.weekdayOrdinal = weekdayOrdinal
        self.quarter = quarter
        self.weekOfMonth = weekOfMonth
        self.weekOfYear = weekOfYear
        self.yearForWeekOfYear = yearForWeekOfYear
    }

    public var leapMonth: Bool {
        return (self as NSDateComponents).leapMonth
    }

    public func date(calendar: NSCalendar = NSCalendar.currentCalendar()) -> Date? {
        return calendar.dateFromComponents(self as NSDateComponents) as Date?
    }
}

extension DateComponents: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return (self as NSDateComponents).description
    }

    public var debugDescription: String {
        return (self as NSDateComponents).debugDescription
    }
}

extension DateComponents: _ObjectiveCBridgeable {
    public typealias _ObjectiveCType = NSDateComponents

    public static func _isBridgedToObjectiveC() -> Bool {
        return true
    }

    public static func _getObjectiveCType() -> Any.Type {
        return NSDateComponents.self
    }

    public func _bridgeToObjectiveC() -> _ObjectiveCType {
        return {
            let dateComponents = NSDateComponents()
            if let era = self.era { dateComponents.era = era }
            if let year = self.year { dateComponents.year = year }
            if let month = self.month { dateComponents.month = month }
            if let day = self.day { dateComponents.day = day }
            if let hour = self.hour { dateComponents.hour = hour }
            if let minute = self.minute { dateComponents.minute = minute }
            if let second = self.second { dateComponents.second = second }
            if let nanosecond = self.nanosecond { dateComponents.nanosecond = nanosecond }
            if let weekday = self.weekday { dateComponents.weekday = weekday }
            if let weekdayOrdinal = self.weekdayOrdinal { dateComponents.weekdayOrdinal = weekdayOrdinal }
            if let quarter = self.quarter { dateComponents.quarter = quarter }
            if let weekOfMonth = self.weekOfMonth { dateComponents.weekOfMonth = weekOfMonth }
            if let weekOfYear = self.weekOfYear { dateComponents.weekOfYear = weekOfYear }
            if let yearForWeekOfYear = self.yearForWeekOfYear { dateComponents.yearForWeekOfYear = yearForWeekOfYear }
            return dateComponents
        }()
    }

    public static func _forceBridgeFromObjectiveC(source: _ObjectiveCType, inout result: DateComponents?) {
        func NSDateComponentUndefinedToNil(value: Int) -> Int? {
            guard value != NSDateComponentUndefined else {
                return nil
            }
            return value
        }

        result = DateComponents(
           era: NSDateComponentUndefinedToNil(source.era),
           year: NSDateComponentUndefinedToNil(source.year),
           month: NSDateComponentUndefinedToNil(source.month),
           day: NSDateComponentUndefinedToNil(source.day),
           hour: NSDateComponentUndefinedToNil(source.hour),
           minute: NSDateComponentUndefinedToNil(source.minute),
           second: NSDateComponentUndefinedToNil(source.second),
           nanosecond: NSDateComponentUndefinedToNil(source.nanosecond),
           weekday: NSDateComponentUndefinedToNil(source.weekday),
           weekdayOrdinal: NSDateComponentUndefinedToNil(source.weekdayOrdinal),
           quarter: NSDateComponentUndefinedToNil(source.quarter),
           weekOfMonth: NSDateComponentUndefinedToNil(source.weekOfMonth),
           weekOfYear: NSDateComponentUndefinedToNil(source.weekOfYear),
           yearForWeekOfYear: NSDateComponentUndefinedToNil(source.yearForWeekOfYear)
       )
    }

    public static func _conditionallyBridgeFromObjectiveC(source: _ObjectiveCType, inout result: DateComponents?) -> Bool {
        DateComponents._forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
}

