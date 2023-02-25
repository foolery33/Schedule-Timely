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
            model.currentDayIndex
        }
        set(newValue) {
            model.currentDayIndex = newValue
        }
    }
    
    func getDaysOfWeek() -> [Date] {
        return MainScreenModel.getDaysOfWeek()
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
    
}
