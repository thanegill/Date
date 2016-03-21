import Foundation

public protocol TimeInterval:
    Equatable,
    Comparable,
    Hashable,
    ArithmeticType,
    SignedNumberType,
    BidirectionalIndexType,
    GeneratorType,
    FloatLiteralConvertible,
    IntegerLiteralConvertible,
    CustomStringConvertible,
    CustomDebugStringConvertible
{
    init(_ value: Double)
    init<T: TimeInterval>(_ value: T)

    var _value: Double { get }
    var nanoseconds: Time.Nanoseconds { get }
    var microseconds: Time.Microseconds { get }
    var milliseconds: Time.Milliseconds { get }
    var seconds: Time.Seconds { get }
    var minutes: Time.Minutes { get }
    var hours: Time.Hours { get }
    var days: Time.Days { get }
    var weeks: Time.Weeks { get }

    var isNegative: Bool { get }
}

extension TimeInterval {
    public init(_ value: Int) {
        self.init(Double(value))
    }

    /// TimeInterval is less than 0 exclusive
    public var isNegative: Bool {
        return self._value.isSignMinus && self.isNotZero
    }

    /// TimeInterval is greater than 0 exclusive
    public var isPositive: Bool {
        return !self._value.isSignMinus && self.isNotZero
    }

    /// TimeInterval is +0.0 or -0.0
    public var isZero: Bool {
        return self._value.isZero
    }

    /// TimeInterval is not +0.0 or -0.0
    public var isNotZero: Bool {
        return !self._value.isZero
    }

    public var roundUp: Self {
        return self.dynamicType.init(ceil(self._value))
    }

    public var roundDown: Self {
        return self.dynamicType.init(floor(self._value))
    }

    public var round: Self {
        return self.dynamicType.init(rint(self._value))
    }
    // FloatLiteralConverable
    public init(floatLiteral value: Double) {
        self.init(value)
    }

    // IntegerLiteralConvertable
    public init(integerLiteral value: Int) {
        self.init(Double(value))
    }

    // BidirectionalIndexType
    public func predecessor() -> Self {
        return Self(self._value - 1.0)
    }

    public func successor() -> Self {
        return Self(self._value + 1.0)
    }

    // GeneratorType
    typealias Element = Self
    public func next() -> Self? {
        return self.successor()
    }

    // CustomStringConvertable
    public var description: String {
        return "\(self._value) \(String(Self))"
    }

    // CustomDebugStringConvertable
    public var debugDescription: String {
        return self.description
    }

    // Hashable
    public var hashValue: Int {
        return self.seconds._value.hashValue
    }
}

// MARK: Equatable/Comparable of same dynamicType
public func ==<T: TimeInterval>(lhs: T, rhs: T) -> Bool {
    return lhs._value == rhs._value
}
public func <<T: TimeInterval>(lhs: T, rhs: T) -> Bool {
    return lhs._value < rhs._value
}

// MARK: Equatable/Comparable of different dynamicType
public func ==<T: TimeInterval, O: TimeInterval>(lhs: T, rhs: O) -> Bool {
    return lhs.seconds == rhs.seconds
}
public func <<T: TimeInterval, O: TimeInterval>(lhs: T, rhs: O) -> Bool {
    return lhs.seconds < rhs.seconds
}

// MARK: ArithmeticType of same dynamicType
public func %<T: TimeInterval>(lhs: T, rhs: T) -> T {
    return T(lhs._value % rhs._value)
}
public func *<T: TimeInterval>(lhs: T, rhs: T) -> T {
    return T(lhs._value * rhs._value)
}
public func +<T: TimeInterval>(lhs: T, rhs: T) -> T {
    return T(lhs._value + rhs._value)
}
public func -<T: TimeInterval>(lhs: T, rhs: T) -> T {
    return T(lhs._value - rhs._value)
}
public func /<T: TimeInterval>(lhs: T, rhs: T) -> T {
    return T(lhs._value / rhs._value)
}

public prefix func -<T: TimeInterval>(value: T) -> T {
    return T(-value._value)
}
public func +=<T: TimeInterval, U: TimeInterval>(inout lhs: T, rhs: U) {
    lhs = lhs + rhs
}
public func -=<T: TimeInterval, U: TimeInterval>(inout lhs: T, rhs: U) {
    lhs = lhs - rhs
}

// MARK: ArithmeticType of different dynamicType
public func %<T: TimeInterval, U: TimeInterval, V: TimeInterval>(lhs: T, rhs: U) -> V {
    return V(lhs.seconds % rhs.seconds)
}
public func *<T: TimeInterval, U: TimeInterval, V: TimeInterval>(lhs: T, rhs: U) -> V {
    return V(lhs.seconds * rhs.seconds)
}
public func +<T: TimeInterval, U: TimeInterval, V: TimeInterval>(lhs: T, rhs: U) -> V {
    return V(lhs.seconds + rhs.seconds)
}
public func -<T: TimeInterval, U: TimeInterval, V: TimeInterval>(lhs: T, rhs: U) -> V {
    return V(lhs.seconds - rhs.seconds)
}
public func /<T: TimeInterval, U: TimeInterval, V: TimeInterval>(lhs: T, rhs: U) -> V {
    return V(lhs.seconds / rhs.seconds)
}

public struct Time  {
    public struct Nanoseconds: TimeInterval {
        /// Number of nanoseconds
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.nanoseconds._value)
        }

        public var nanoseconds: Nanoseconds {
            return self
        }

        public var microseconds: Microseconds {
            return Microseconds(self.nanoseconds._value / 1000)
        }

        public var milliseconds: Milliseconds {
            return Milliseconds(self.microseconds._value / 1000)
        }

        public var seconds: Seconds {
            return Seconds(self.milliseconds._value / 1000)
        }

        public var minutes: Minutes {
            return Minutes(self.seconds._value / 60.0)
        }

        public var hours: Hours {
            return Hours(self.minutes._value / 60.0)
        }

        public var days: Days {
            return Days(self.hours._value / 24.0)
        }

        public var weeks: Weeks {
            return Weeks(self.days._value / 7)
        }
    }

    public struct Microseconds: TimeInterval {
        /// Number of microseconds
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.microseconds._value)
        }

        public var nanoseconds: Nanoseconds {
            return Nanoseconds(self.microseconds._value * 1000)
        }

        public var microseconds: Microseconds {
            return self
        }

        public var milliseconds: Milliseconds {
            return Milliseconds(self.microseconds._value / 1000)
        }

        public var seconds: Seconds {
            return Seconds(self.milliseconds._value / 1000)
        }

        public var minutes: Minutes {
            return Minutes(self.seconds._value / 60.0)
        }

        public var hours: Hours {
            return Hours(self.minutes._value / 60.0)
        }

        public var days: Days {
            return Days(self.hours._value / 24.0)
        }

        public var weeks: Weeks {
            return Weeks(self.days._value / 7)
        }
    }

    public struct Milliseconds: TimeInterval {
        /// Number of milliseconds
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.milliseconds._value)
        }

        public var nanoseconds: Nanoseconds {
            return Nanoseconds(self.microseconds._value * 1000)
        }

        public var microseconds: Microseconds {
            return Microseconds(self.milliseconds._value * 1000)
        }

        public var milliseconds: Milliseconds {
            return self
        }

        public var seconds: Seconds {
            return Seconds(self.milliseconds._value / 1000)
        }

        public var minutes: Minutes {
            return Minutes(self.seconds._value / 60.0)
        }

        public var hours: Hours {
            return Hours(self.minutes._value / 60.0)
        }

        public var days: Days {
            return Days(self.hours._value / 24.0)
        }

        public var weeks: Weeks {
            return Weeks(self.days._value / 7)
        }
    }

    public struct Seconds: TimeInterval {
        /// Number of seconds
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.seconds._value)
        }

        public var nanoseconds: Nanoseconds {
            return Nanoseconds(self.microseconds._value * 1000)
        }

        public var microseconds: Microseconds {
            return Microseconds(self.milliseconds._value * 1000)
        }

        public var milliseconds: Milliseconds {
            return Milliseconds(self.seconds._value * 1000)
        }

        public var seconds: Seconds {
            return self
        }

        public var minutes: Minutes {
            return Minutes(self.seconds._value / 60.0)
        }

        public var hours: Hours {
            return Hours(self.minutes._value / 60.0)
        }

        public var days: Days {
            return Days(self.hours._value / 24.0)
        }

        public var weeks: Weeks {
            return Weeks(self.days._value / 7)
        }
    }

    public struct Minutes: TimeInterval {
        /// Number of minutes
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.minutes._value)
        }

        public var nanoseconds: Nanoseconds {
            return Nanoseconds(self.microseconds._value * 1000)
        }

        public var microseconds: Microseconds {
            return Microseconds(self.milliseconds._value * 1000)
        }

        public var milliseconds: Milliseconds {
            return Milliseconds(self.seconds._value * 1000)
        }

        public var seconds: Seconds {
            return Seconds(self.minutes._value * 60.0)
        }

        public var minutes: Minutes {
            return self
        }

        public var hours: Hours {
            return Hours(self.minutes._value / 60.0)
        }

        public var days: Days {
            return Days(self.hours._value / 24.0)
        }

        public var weeks: Weeks {
            return Weeks(self.days._value / 7)
        }
    }

    public struct Hours: TimeInterval {
        /// Number of hours
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.hours._value)
        }

        public var nanoseconds: Nanoseconds {
            return Nanoseconds(self.microseconds._value * 1000)
        }

        public var microseconds: Microseconds {
            return Microseconds(self.milliseconds._value * 1000)
        }

        public var milliseconds: Milliseconds {
            return Milliseconds(self.seconds._value * 1000)
        }

        public var seconds: Seconds {
            return Seconds(self.minutes._value * 60.0)
        }

        public var minutes: Minutes {
            return Minutes(self.hours._value * 60)
        }

        public var hours: Hours {
            return self
        }

        public var days: Days {
            return Days(self.hours._value / 24.0)
        }

        public var weeks: Weeks {
            return Weeks(self.days._value / 7)
        }
    }

    public struct Days: TimeInterval {
        /// Number of days
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.days._value)
        }

        public var nanoseconds: Nanoseconds {
            return Nanoseconds(self.microseconds._value * 1000)
        }

        public var microseconds: Microseconds {
            return Microseconds(self.milliseconds._value * 1000)
        }

        public var milliseconds: Milliseconds {
            return Milliseconds(self.seconds._value * 1000)
        }

        public var seconds: Seconds {
            return Seconds(self.minutes._value * 60.0)
        }

        public var minutes: Minutes {
            return Minutes(self.hours._value * 60.0)
        }

        public var hours: Hours {
            return Hours(self.days._value * 24.0)
        }

        public var days: Days {
            return self
        }

        public var weeks: Weeks {
            return Weeks(self.days._value / 7)
        }
    }

    public struct Weeks: TimeInterval {
        /// Number of weeks
        public let _value: Double

        public init(_ value: Double) {
            self._value = value
        }

        public init<T: TimeInterval>(_ value: T) {
            self.init(value.weeks._value)
        }

        public var nanoseconds: Nanoseconds {
            return Nanoseconds(self.microseconds._value * 1000)
        }

        public var microseconds: Microseconds {
            return Microseconds(self.milliseconds._value * 1000)
        }

        public var milliseconds: Milliseconds {
            return Milliseconds(self.seconds._value * 1000)
        }

        public var seconds: Seconds {
            return Seconds(self.minutes._value * 60.0)
        }

        public var minutes: Minutes {
            return Minutes(self.hours._value * 60.0)
        }

        public var hours: Hours {
            return Hours(self.days._value * 24.0)
        }

        public var days: Days {
            return Days(self.weeks._value * 7)
        }

        public var weeks: Weeks {
            return self
        }
    }
}
