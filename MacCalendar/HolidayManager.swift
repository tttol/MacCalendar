import Foundation

struct Holiday {
    let date: Date
    let name: String
}

class HolidayManager: ObservableObject {
    @Published var holidays: Set<Date> = []
    private let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy/M/d"
        dateFormatter.locale = Locale(identifier: "en_US")
        loadHolidays()
    }
    
    func isHoliday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return holidays.contains { holiday in
            calendar.isDate(date, inSameDayAs: holiday)
        }
    }
    
    private func loadHolidays() {
        guard let path = Bundle.main.path(forResource: "japanese_holiday", ofType: "csv"),
              let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            print("Could not load japanese_holiday.csv")
            return
        }
        
        parseCSV(content)
    }
    
    private func parseCSV(_ content: String) {
        let lines = content.components(separatedBy: .newlines)
        
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if trimmedLine.isEmpty { continue }
            
            let components = trimmedLine.components(separatedBy: ",")
            if components.count >= 2 {
                let dateString = components[0].trimmingCharacters(in: .whitespaces)
                
                if let date = dateFormatter.date(from: dateString) {
                    holidays.insert(date)
                }
            }
        }
    }
}