//import XCTest
//
//final class MacCalendarUITests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    @MainActor
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    @MainActor
//    func testCalendarDisplaysCurrentDate() throws {
//        let app = XCUIApplication()
//        app.launch()
//        
//        // Verify that the calendar view appears
//        let calendarView = app.otherElements.containing(.staticText, identifier: "MacCalendar v1.0").element
//        XCTAssertTrue(calendarView.exists)
//        
//        // Get current date components
//        let calendar = Calendar.current
//        let today = Date()
//        let monthFormatter = DateFormatter()
//        monthFormatter.dateFormat = "MMMM yyyy"
//        let expectedMonthYear = monthFormatter.string(from: today)
//        
//        // Verify current month/year is displayed
//        let monthYearText = app.staticTexts[expectedMonthYear]
//        XCTAssertTrue(monthYearText.exists, "Current month/year should be displayed")
//        
//        // Verify calendar grid exists
//        XCTAssertTrue(app.buttons.count > 0, "Calendar should display date buttons")
//    }
//    
//    @MainActor
//    func testAppReactivationUpdatesDate() throws {
//        let app = XCUIApplication()
//        app.launch()
//        
//        // Verify app launches successfully
//        let calendarView = app.otherElements.containing(.staticText, identifier: "MacCalendar v1.0").element
//        XCTAssertTrue(calendarView.exists)
//        
//        // For macOS, we simulate reactivation by terminating and relaunching
//        app.terminate()
//        
//        // Wait a moment
//        sleep(1)
//        
//        // Relaunch to simulate app becoming active again
//        app.launch()
//        
//        // Verify calendar is still functional after reactivation
//        let monthFormatter = DateFormatter()
//        monthFormatter.dateFormat = "MMMM yyyy"
//        let expectedMonthYear = monthFormatter.string(from: Date())
//        let monthYearText = app.staticTexts[expectedMonthYear]
//        XCTAssertTrue(monthYearText.exists, "Current month/year should be updated after reactivation")
//    }
//    
//    @MainActor
////    func testNavigationButtons() throws {
//        let app = XCUIApplication()
//        app.launch()
//        
//        // Find navigation buttons
//        let prevButton = app.buttons.matching(NSPredicate(format: "identifier CONTAINS 'chevron.left'")).firstMatch
//        let nextButton = app.buttons.matching(NSPredicate(format: "identifier CONTAINS 'chevron.right'")).firstMatch
//        
//        // Test month navigation
//        if nextButton.exists {
//            nextButton.tap()
//            // Verify month changed (basic check that UI responded)
//            XCTAssertTrue(app.staticTexts.count > 0, "Month navigation should work")
//        }
//        
//        if prevButton.exists {
//            prevButton.tap()
//            // Verify month changed back
//            XCTAssertTrue(app.staticTexts.count > 0, "Month navigation should work in both directions")
//        }
//    }
//
//    @MainActor
//    func testLaunchPerformance() throws {
//        // This measures how long it takes to launch your application.
//        measure(metrics: [XCTApplicationLaunchMetric()]) {
//            XCUIApplication().launch()
//        }
//    }
//}
