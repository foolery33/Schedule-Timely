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
    
    var groupId: String {
        get {
            model.groupId
        }
        set(newValue) {
            model.groupId = newValue
        }
    }
    
    var teacherId: String {
        get {
            model.teacherId
        }
        set(newValue) {
            model.teacherId = newValue
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
    
    func getGroupSchedule(date: String, completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        ScheduleViewModel.shared.getGroupSchedule(date: date, groupId: UserStorage.shared.fetchGroupId()) { [unowned self] (result: Result<[LessonModel], AppError>) in
            switch result {
            case .success(let lessons):
                self.weekLessons = lessons
                completion(true)
            case .failure(let error):
                self.error = error
                completion(false)
            }
            
        }
    }
    
}
