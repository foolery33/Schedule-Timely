//
//  MainScreenModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import Foundation

struct MainScreenModel {
    
    var daysOfWeek = getDaysOfWeek(for: Date())
    var currentDayIndex = weekdayIndex(for: Date())
    var isAscendingOrder: Bool = true
    var groupId: String = ""
    var teacherId: String = ""
    var weekLessons: [LessonModel] = []
    var sortedWeekLessons: [[LessonModel]] = [[], [], [], [], [], [], []]
    
    func isAscending() -> Bool {
        self.isAscendingOrder
    }
    mutating func changeOrder() -> Void {
        self.isAscendingOrder.toggle()
    }
    
    func getCurrentDayIndex() -> Int {
        self.currentDayIndex
    }
    mutating func setCurrentDayIndex(index: Int) -> Void {
        self.currentDayIndex = index
    }
    
    static func getDaysOfWeek(for date: Date) -> [Date] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ru_RU") // Установка локали (опционально)

        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!

        var dates = [Date]()

        for day in 0...6 {
            guard let date = calendar.date(byAdding: .day, value: day, to: startOfWeek) else {
                continue
            }
            dates.append(date)
        }

        return dates
    }
    
    static func weekdayIndex(for date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: date).capitalized

        switch dayOfWeek {
        case "Понедельник":
            return 0
        case "Вторник":
            return 1
        case "Среда":
            return 2
        case "Четверг":
            return 3
        case "Пятница":
            return 4
        case "Суббота":
            return 5
        case "Воскресенье":
            return 6
        default:
            return -1
        }
    }
    
    func getDayOfMonthByDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    func abbreviatedMonthName(date: Date, count: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let month = dateFormatter.string(from: date)
        return String(month.prefix(count)).capitalized
    }
    
    func getYearFromDate(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    
    func getDayOfWeekByDate(date: Date, lettersCount: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        let index = weekday.index(weekday.startIndex, offsetBy: lettersCount)
        return String(weekday[..<index]).capitalized
    }
    
    func isToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let otherDate = calendar.startOfDay(for: date)
        return today == otherDate
    }
    
    func getDateWithOffset(from date: Date, byDays days: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
}
