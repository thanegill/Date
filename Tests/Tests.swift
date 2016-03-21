import Quick
import Nimble
import Date

public func equal<T: TimeInterval, U: TimeInterval>(expectedValue: T?) -> MatcherFunc<U> {
    return equal(expectedValue)
}

public func ==<T: TimeInterval, U: TimeInterval>(lhs: Expectation<U>, rhs: T?) {
    lhs.to(equal(rhs))
}


class DateSpec: QuickSpec {
    override func spec() {
        describe("behaves like NSDate") {
            it("Can be cast to NSDate") {
                let date = Date()
                let nsdate = date as NSDate
                expect(date.seconds._value) == nsdate.timeIntervalSinceReferenceDate
            }

            it("can be cast from NSDate") {
                let nsdate = NSDate()
                let date = nsdate as Date
                expect(date.seconds._value) == nsdate.timeIntervalSinceReferenceDate
            }

            it("has the same 'now'") {
                let date = Date()
                let nsdate = NSDate()
                expect(date.seconds._value).to(beCloseTo(nsdate.timeIntervalSinceReferenceDate, within: 0.001))
            }

            it("has the same time interval from 1970 to 2001") {
                let timeInterval: Time.Seconds = Date.TimeIntervalFrom1970ToReferenceDate()
                expect(timeInterval.seconds._value) == NSTimeIntervalSince1970
            }

            it("has the same distant future") {
                expect(Date.DistantFuture.seconds._value) == NSDate.distantFuture().timeIntervalSinceReferenceDate
            }

            it("has the same distant past") {
                expect(Date.DistantPast.seconds._value) == NSDate.distantPast().timeIntervalSinceReferenceDate
            }

            it("has the same timeinterval since refernce date") {
                let timeInterval: Time.Seconds = Date.UnixEpoch.timeIntervalSinceReferenceDate()
                expect(timeInterval.seconds._value) == NSDate(timeIntervalSince1970: 0).timeIntervalSinceReferenceDate
            }
        }

        describe("Time Interval") {
            it("has correct unit conversions") {
                expect(1.Milliseconds) == 1000000.Nanoseconds
                expect(1.Seconds) == 1000.Milliseconds
                expect(1.Minutes) == 60.Seconds
                expect(1.Hours) == 60.Minutes
                expect(1.Days) == 24.Hours
                expect(1.Weeks) == 7.Days
            }

            it("can be added") {
                expect(4.5.Minutes) == 270.Seconds
                expect(4.5.Minutes) == 270.Seconds
            }
        }

        describe("Date Componets") {
            it("correctly converts to components and back again") {
                let date = Date()
                expect(date.components().date()) == date
            }
//            it("") {
//                let now = Date()
//                print(now.components)
//                let dc = DateComponents(year: 2016, month: 2, day: 29, hour: 12, minute: 9)
//                print(dc.date)
//            }

//            it("leapMonth") {
//                let dc = DateComponents(year: 2016, month: 2, day: 29, hour: 12, minute: 9)
//
//                expect(dc.leapMonth).to(beTrue())
//            }
        }
    }
}
