//
//  GetWeekSchedule.swift
//  Schedule
//
//  Created by admin on 07.03.2023.
//

import Foundation

class GetWeekSchedule {
    
    func getWeekSchedule(from lessons: [LessonModel], dates: [Date]) -> [[LessonModel]] {
        
        var result: [[LessonModel]] = []
        
        for date in 0..<dates.count {
            result.append([])
            for lesson in 0..<lessons.count {
                if(formatDate(lessons[lesson].date) == ConvertDateIntoString().convert(dates[date])) {
                    result[date].append(lessons[lesson])
                }
            }
            if(result[date].count > 1) {
                result[date] = sortLessons(lessons: result[date])
            }
        }
        
        return result
        
    }
    
    // Функция, принимающая на вход строку-дату в формате "yyyy-MM-dd'T'HH:mm:ss"
    // и возвращающая строку-дату в формате "yyyy/MM/dd"
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    // Функция, сортирующая уроки в конкретный день в заданном порядке
    func sortLessons(lessons: [LessonModel]) -> [LessonModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return lessons.sorted { lesson1, lesson2 in
            let date1 = dateFormatter.date(from: lesson1.timeInterval.startTime)!
            let date2 = dateFormatter.date(from: lesson2.timeInterval.startTime)!
            return date1 < date2
        }
    }
    
}
