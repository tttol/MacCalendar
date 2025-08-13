import Testing
import Foundation
@testable import MacCalendar

struct HolidayManagerTests {
    
    @Test
    func testHolidayInitialization() {
        let holidayManager = HolidayManager()
        
        #expect(!holidayManager.holidays.isEmpty)
    }
    
    @Test 
    func testKnownHoliday() {
        let holidayManager = HolidayManager()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/M/d"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        // Test New Year's Day 2025
        if let newYearDate = dateFormatter.date(from: "2025/1/1") {
            #expect(holidayManager.isHoliday(newYearDate))
        }
    }
    
    @Test
    func testNonHoliday() {
        let holidayManager = HolidayManager()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/M/d"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        // Test a regular day that should not be a holiday
        if let regularDate = dateFormatter.date(from: "2025/8/12") {
            #expect(!holidayManager.isHoliday(regularDate))
        }
    }
}
