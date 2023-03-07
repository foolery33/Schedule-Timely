//
//  DaySchedule.swift
//  Schedule
//
//  Created by admin on 06.03.2023.
//

import Foundation

class DaySchedule {
    
    func getDaySchedule(for day: Date, from week: [LessonModel], isAscendingOrder: Bool) -> [LessonModel] {
        var result: [LessonModel] = []
        for i in 0..<week.count {
            if(ConvertDateIntoString().convert(day) == formatDate(week[i].date)) {
                result.append(week[i])
            }
        }
        if(result.count < 2) {
            return result
        }
        else {
            return sortLessons(lessons: result, isAscendingOrder: isAscendingOrder)
        }
    }
    
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    func sortLessons(lessons: [LessonModel], isAscendingOrder: Bool) -> [LessonModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return lessons.sorted { lesson1, lesson2 in
            let date1 = dateFormatter.date(from: lesson1.date)!
            let date2 = dateFormatter.date(from: lesson2.date)!
            if(isAscendingOrder) {
                return date1 < date2
            }
            else {
                return date1 > date2
            }
        }
    }
    
}
