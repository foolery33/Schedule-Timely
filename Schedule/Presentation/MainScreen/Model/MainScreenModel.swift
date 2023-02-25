//
//  MainScreenModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import Foundation

struct MainScreenModel {
    
    var daysOfWeek = getDaysOfWeek()
    var currentDayIndex = weekdayIndex(for: Date())
    
    static func getDaysOfWeek() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let dayOfWeek = calendar.component(.weekday, from: today)
        let daysInWeek = 7
        let firstWeekday = 2 // 1 is Sunday, 2 is Monday
        let offset = firstWeekday - dayOfWeek
        var dateComponents = DateComponents()
        dateComponents.day = offset
        guard let monday = calendar.date(byAdding: dateComponents, to: today) else {
            return []
        }
        var dates: [Date] = []
        for i in 0..<daysInWeek {
            let date = calendar.date(byAdding: .day, value: i, to: monday)!
            dates.append(date)
        }
        return dates
    }
    
    static func weekdayIndex(for date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        let weekday = (components.weekday! + 5) % 7
        return weekday
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
    
}
