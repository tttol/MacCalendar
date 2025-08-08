import SwiftUI

@main
struct MacCalendarApp: App {
    var body: some Scene {
        MenuBarExtra(
            "MacCalendar",
            systemImage: "calendar"
        ) {
            ContentView()
                .frame(width: 350, height: 400)
        }
        .menuBarExtraStyle(.window)
    }
}
