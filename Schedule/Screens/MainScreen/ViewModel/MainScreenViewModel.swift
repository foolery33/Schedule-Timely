//
//  MainScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class MainScreenViewModel: ObservableObject {
    
    @Published private var model: MainScreenModel = MainScreenModel()
    
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
    
}
