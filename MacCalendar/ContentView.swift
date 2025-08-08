import SwiftUI

struct ContentView: View {
    @State private var currentDate = Date()
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Close button header
            HStack {
                Spacer()
                Button(action: closeWindow) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)
            
            CustomCalendarView(selectedDate: $selectedDate)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Footer
            HStack {
                Spacer()
                Text("MacCalendar v1.0")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 4)
        }
        .background(Color(NSColor.windowBackgroundColor))
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentDate = Date()
        }
    }
    
    private func closeWindow() {
        if let window = NSApplication.shared.windows.first(where: { $0.isVisible }) {
            window.close()
        }
    }
    
    private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}

struct CustomCalendarView: View {
    @Binding var selectedDate: Date
    @State private var currentMonth = Date()
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    private var monthYearString: String {
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: currentMonth)
    }
    
    private var daysInMonth: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth) else {
            return []
        }
        
        let firstOfMonth = monthInterval.start
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let daysToSubtract = firstWeekday - 1
        
        guard let startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: firstOfMonth) else {
            return []
        }
        
        var days: [Date] = []
        for i in 0..<42 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                days.append(date)
            }
        }
        return days
    }
    
    var body: some View {
        VStack(spacing: 4) {
            // Header with month/year and navigation
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text(monthYearString)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            // Weekday headers
            HStack(spacing: 0) {
                ForEach(Array(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].enumerated()), id: \.offset) { index, day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(weekdayColor(for: index))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 4) {
                ForEach(daysInMonth, id: \.self) { date in
                    DayView(
                        date: date,
                        selectedDate: $selectedDate,
                        currentMonth: currentMonth
                    )
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func previousMonth() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
        }
    }
    
    private func nextMonth() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
        }
    }
    
    private func weekdayColor(for index: Int) -> Color {
        switch index {
        case 0: return .red      // Sunday
        case 6: return .blue     // Saturday
        default: return .white   // Weekdays
        }
    }
}

struct DayView: View {
    let date: Date
    @Binding var selectedDate: Date
    let currentMonth: Date
    
    private let calendar = Calendar.current
    
    private var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private var isToday: Bool {
        calendar.isDateInToday(date)
    }
    
    private var isSelected: Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    private var isInCurrentMonth: Bool {
        calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
    }
    
    private var weekdayColor: Color {
        let weekday = calendar.component(.weekday, from: date)
        switch weekday {
        case 1: return .red      // Sunday
        case 7: return .blue     // Saturday
        default: return .white   // Weekdays
        }
    }
    
    var body: some View {
        Button(action: { selectedDate = date }) {
            Text(dayNumber)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 32, height: 32)
                .background(
                    Group {
                        if isSelected {
                            Circle()
                                .fill(Color.blue)
                        } else if isToday {
                            Circle()
                                .stroke(Color.blue, lineWidth: 2)
                        } else {
                            Circle()
                                .fill(Color.clear)
                        }
                    }
                )
                .foregroundColor(
                    isSelected ? .white :
                    isToday ? .blue :
                    isInCurrentMonth ? weekdayColor : .secondary
                )
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(isInCurrentMonth ? 1.0 : 0.3)
    }
}

#Preview {
    ContentView()
        .frame(width: 350, height: 400)
}
