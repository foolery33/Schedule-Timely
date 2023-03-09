//
//  MainScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class MainScreenViewModel: LoadingDataClass {
    
    @Published private var model: MainScreenModel = MainScreenModel()
    
    let toggleValidationStatusClosure: (Bool) -> Void
    
    init(toggleValidationStatusClosure: @escaping (Bool) -> Void) {
        self.toggleValidationStatusClosure = toggleValidationStatusClosure
    }
    
    var daysOfWeek: [Date] {
        get {
            model.daysOfWeek
        }
        set(newValue) {
            model.daysOfWeek = newValue
        }
    }
    
    var currentDayIndex: Int {
        get {
            self.getCurrentDayIndex()
        }
        set(newValue) {
            self.setCurrentDayIndex(index: newValue)
        }
    }
    
    var isAscendingOrder: Bool {
        get {
            model.isAscendingOrder
        }
        set(newValue) {
            model.isAscendingOrder = newValue
        }
    }
    
    var weekLessons: [LessonModel] {
        get {
            model.weekLessons
        }
        set(newValue) {
            model.weekLessons = newValue
        }
    }
    
    var sortedWeekLessons: [[LessonModel]] {
        get {
            model.sortedWeekLessons
        }
        set(newValue) {
            model.sortedWeekLessons = newValue
        }
    }
    
    func getCurrentDayIndex() -> Int {
        self.model.getCurrentDayIndex()
    }
    func setCurrentDayIndex(index: Int) {
        self.model.setCurrentDayIndex(index: index)
    }
    
    func isAscending() -> Bool {
        self.model.isAscending()
    }
    func changeOrder() -> Void {
        self.model.changeOrder()
    }
    
    func getDaysOfWeek(for date: Date) -> [Date] {
        return MainScreenModel.getDaysOfWeek(for: date)
    }
    
    func weekdayIndex(for date: Date) -> Int {
        return MainScreenModel.weekdayIndex(for: date)
    }
    
    func getDayOfMonthByDate(date: Date) -> String {
        return model.getDayOfMonthByDate(date: date)
    }
    
    func abbreviatedMonthName(date: Date, count: Int) -> String {
        return model.abbreviatedMonthName(date: date, count: count)
    }
    
    func getYearFromDate(_ date: Date) -> Int {
        return model.getYearFromDate(date)
    }
    
    func getDayOfWeekByDate(date: Date, lettersCount: Int) -> String {
        return model.getDayOfWeekByDate(date: date, lettersCount: lettersCount)
    }
    
    func isToday(_ date: Date) -> Bool {
        return model.isToday(date)
    }
    
    func getDateWithOffset(from date: Date, byDays days: Int) -> Date {
        return model.getDateWithOffset(from: date, byDays: days)
    }
    
    func getGroupSchedule(date: String, groupId: String, completion: @escaping (Bool) -> Void) {
        showProgressView = true
        ScheduleViewModel.shared.getGroupSchedule(date: date, groupId: groupId) { [unowned self] (result: Result<[LessonModel], AppError>) in
            switch result {
            case .success(let lessons):
                self.weekLessons = lessons
                self.sortedWeekLessons = GetWeekSchedule().getWeekSchedule(from: self.weekLessons, dates: self.daysOfWeek)
                completion(true)
            case .failure(let error):
                self.error = error
                completion(false)
            }
            
        }
    }
    
    func getTeacherSchedule(date: String, teacherId: String, completion: @escaping (Bool) -> Void) {
        showProgressView = true
        ScheduleViewModel.shared.getTeacherSchedule(date: date, teacherId: teacherId) { [unowned self] (result: Result<[LessonModel], AppError>) in
            switch result {
            case .success(let lessons):
                self.weekLessons = lessons
                self.sortedWeekLessons = GetWeekSchedule().getWeekSchedule(from: self.weekLessons, dates: self.daysOfWeek)
                completion(true)
            case .failure(let error):
                self.error = error
                completion(false)
            }
            
        }
    }
    
    func getClassroomSchedule(date: String, classroomId: String, completion: @escaping (Bool) -> Void) {
        showProgressView = true
        ScheduleViewModel.shared.getClassroomSchedule(date: date, classroomId: classroomId) { [unowned self] (result: Result<[LessonModel], AppError>) in
            switch result {
            case .success(let lessons):
                self.weekLessons = lessons
                self.sortedWeekLessons = GetWeekSchedule().getWeekSchedule(from: self.weekLessons, dates: self.daysOfWeek)
                completion(true)
            case .failure(let error):
                self.error = error
                completion(false)
            }
            
        }
    }
}
