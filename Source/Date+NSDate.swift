import Foundation

extension Date: _ObjectiveCBridgeable {
    public typealias _ObjectiveCType = NSDate

    public static func _isBridgedToObjectiveC() -> Bool {
        return true
    }

    public static func _getObjectiveCType() -> Any.Type {
        return NSDate.self
    }

    public func _bridgeToObjectiveC() -> Date._ObjectiveCType {
        let timeInterval: Time.Seconds = self.timeIntervalSinceReferenceDate()
        return NSDate(timeIntervalSinceReferenceDate: timeInterval._value)
    }

    public static func _forceBridgeFromObjectiveC(source: Date._ObjectiveCType, inout result: Date?) {
        result = Date(timeIntervalSinceReferenceDate: source.timeIntervalSinceReferenceDate.Seconds)
    }

    public static func _conditionallyBridgeFromObjectiveC(source: Date._ObjectiveCType, inout result: Date?) -> Bool {
        Date._forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
}
