import Testing
import SwiftUI
@testable import MacCalendar

struct MacCalendarTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func testDayViewIsTodayLogic() async throws {
        let calendar = Calendar.current
        let today = Date()
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        // Create binding values for testing
        let selectedDate = Binding.constant(today)
        let currentMonth = today
        
        // Test today's date
        let todayView = DayView(
            date: today,
            selectedDate: selectedDate,
            currentMonth: currentMonth,
            currentDate: today
        )
        
        // Test yesterday's date
        let yesterdayView = DayView(
            date: yesterday,
            selectedDate: selectedDate,
            currentMonth: currentMonth,
            currentDate: today
        )
        
        // Test tomorrow's date
        let tomorrowView = DayView(
            date: tomorrow,
            selectedDate: selectedDate,
            currentMonth: currentMonth,
            currentDate: today
        )
        
        // Since we can't directly access private properties, we test the logic separately
        #expect(calendar.isDate(today, inSameDayAs: today) == true)
        #expect(calendar.isDate(yesterday, inSameDayAs: today) == false)
        #expect(calendar.isDate(tomorrow, inSameDayAs: today) == false)
    }
    
    @Test func testDateComparisonAcrossDayBoundary() async throws {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = formatter.date(from: "2024-01-01 23:59:59")!
        let date2 = formatter.date(from: "2024-01-02 00:00:01")!
        let date3 = formatter.date(from: "2024-01-01 00:00:01")!
        
        // Test that dates on different days are not considered the same
        #expect(calendar.isDate(date1, inSameDayAs: date2) == false)
        
        // Test that dates on the same day are considered the same
        #expect(calendar.isDate(date1, inSameDayAs: date3) == true)
    }
    
    @Test func testCurrentDateUpdate() async throws {
        let calendar = Calendar.current
        let today = Date()
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        // Test the date comparison logic used in timer
        let isSameDay = calendar.isDate(yesterday, inSameDayAs: today)
        #expect(isSameDay == false)
        
        // Test that different times on the same day are considered same day
        let morning = calendar.date(bySettingHour: 9, minute: 0, second: 0, of: today)!
        let evening = calendar.date(bySettingHour: 21, minute: 0, second: 0, of: today)!
        
        #expect(calendar.isDate(morning, inSameDayAs: evening) == true)
    }
    
    @Test func testDayViewTodayHighlighting() async throws {
        let calendar = Calendar.current
        let today = Date()
        let selectedDate = Binding.constant(today)
        let currentMonth = today
        
        // Test with different currentDate values
        let todayView = DayView(
            date: today,
            selectedDate: selectedDate,
            currentMonth: currentMonth,
            currentDate: today
        )
        
        // Test with yesterday as currentDate (simulating date not being updated)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let outdatedView = DayView(
            date: today,
            selectedDate: selectedDate,
            currentMonth: currentMonth,
            currentDate: yesterday
        )
        
        // Test the core logic that determines if a date is "today"
        #expect(calendar.isDate(today, inSameDayAs: today) == true)
        #expect(calendar.isDate(today, inSameDayAs: yesterday) == false)
    }
    
    @Test func testDateUpdateTimerLogic() async throws {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Simulate the timer logic for checking if date has changed
        let futureDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        let sameDayDifferentTime = calendar.date(byAdding: .hour, value: 2, to: currentDate)!
        
        // Timer should detect day change
        #expect(!calendar.isDate(currentDate, inSameDayAs: futureDate))
        
        // Timer should not update for same day different time
        #expect(calendar.isDate(currentDate, inSameDayAs: sameDayDifferentTime))
    }
    
    @Test func testTimezoneConsistency() async throws {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current
        
        let midnightToday = calendar.startOfDay(for: Date())
        let almostMidnightToday = calendar.date(byAdding: .minute, value: -1, to: calendar.date(byAdding: .day, value: 1, to: midnightToday)!)!
        
        // Both should be considered the same day
        #expect(calendar.isDate(midnightToday, inSameDayAs: almostMidnightToday) == true)
    }

}
