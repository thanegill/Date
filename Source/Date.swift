import CoreFoundation

public func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.seconds == rhs.seconds
}
public func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.seconds < rhs.seconds
}

public struct Date: Equatable, Comparable, Hashable {
    public var hashValue: Int {
        return self.seconds._value.hashValue
    }

    /// Number of seconds since 00:00:00 UTC on 1 January 2001
    public let seconds: Time.Seconds

    /// Returns a Date initialized to the current date and time.
    public init() {
        var tv = timeval()
        withUnsafeMutablePointer(&tv) { t in
            gettimeofday(t, nil)
        }
        let timestamp: Time.Seconds = tv.tv_sec.Seconds + Double(tv.tv_usec).Microseconds
        self.init(timeIntervalSince1970: timestamp)
    }

    /// Returns a Date initialized to the reference date, January 1st, 2001, with added date components.
    public init<T: TimeInterval>(timeIntervalSinceReferenceDate timeInterval: T) {
        self.seconds = timeInterval.seconds
    }

    /// Returns a Date initialized to the current date plus date components.
    public init<T: TimeInterval>(timeIntervalSinceNow timeInterval: T) {
        self = Date().add(timeInterval)
    }

    /// Return sa Date initialized to, January 1st, 1970, with added date components.
    public init<T: TimeInterval>(timeIntervalSince1970 timeInterval: T) {
        self = Date.UnixEpoch.add(timeInterval)
    }
}

// MARK: Constants
extension Date {
    /// Number of seconds from January 1st, 1970 to the reference date, January 1st, 2001.
    public static func TimeIntervalFrom1970ToReferenceDate<T: TimeInterval>() -> T {
        return T(kCFAbsoluteTimeIntervalSince1970.Seconds)
    }

    /// Unix Epoch date, 00:00:00 UTC 1 January 1970.
    public static let UnixEpoch: Date = Date(timeIntervalSinceReferenceDate: -kCFAbsoluteTimeIntervalSince1970.Seconds)
    /// Apple Cocoa Framework Reference date, 00:00:00 UTC 1 January 2001.
    public static let ReferenceDate: Date = Date(timeIntervalSinceReferenceDate: 0.Seconds)
    /// 63113904000 Seconds after 00:00:00 UTC 1 January 2001
    public static let DistantFuture: Date = Date(timeIntervalSinceReferenceDate: 63113904000.0.Seconds)
    /// 63114076800 Seconds before 00:00:00 UTC 1 January 2001
    public static let DistantPast: Date = Date(timeIntervalSinceReferenceDate: -63114076800.0.Seconds)
}

extension Date {
    public func timeIntervalSince<T: TimeInterval>(date: Date) -> T {
        return self.timeIntervalSinceReferenceDate() - date.timeIntervalSinceReferenceDate()
    }

    public func timeIntervalSinceNow<T: TimeInterval>() -> T {
        return self.timeIntervalSince(Date())
    }

    public func timeIntervalSince1970<T: TimeInterval>() -> T {
        return Date.TimeIntervalFrom1970ToReferenceDate() + self.timeIntervalSinceReferenceDate()
    }

    public func timeIntervalSinceReferenceDate<T: TimeInterval>() -> T {
        return T(self.seconds)
    }
}

extension Date {
    public func add<T: TimeInterval>(timeInterval: T) -> Date {
        return Date(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate() + timeInterval)
    }

    public func subtract<T: TimeInterval>(timeInterval: T) -> Date {
        return Date(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate() - timeInterval)
    }
}

public func +<T: TimeInterval>(lhs: Date, rhs: T) -> Date {
    return lhs.add(rhs)
}
public func -<T: TimeInterval>(lhs: Date, rhs: T) -> Date {
    return lhs.subtract(rhs)
}

public func +=<T: TimeInterval>(inout lhs: Date, rhs: T) {
    lhs = lhs.add(rhs)
}
public func -=<T: TimeInterval>(inout lhs: Date, rhs: T) {
    lhs = lhs.subtract(rhs)
}

extension Date {
    public func earlierDate(anotherDate: Date) -> Date {
        if self < anotherDate {
            return self
        } else {
            return anotherDate
        }
    }

    public func laterDate(anotherDate: Date) -> Date {
        if self < anotherDate {
            return anotherDate
        } else {
            return self
        }
    }

    public func equal<T: TimeInterval>(date: Date, within: T) -> Bool {
        return abs(self.timeIntervalSinceReferenceDate() - date.timeIntervalSinceReferenceDate()) < within
    }

    public var isPastNow: Bool {
        return self > Date()
    }

    public var isBeforeNow: Bool {
        return self < Date()
    }
}

extension Date: CustomStringConvertible {
    public var description: String {
        return (self as NSDate).description
    }
}

extension Date: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.description
    }
}
