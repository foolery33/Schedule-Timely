//
//  TeachePickerScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class TeacherPickerScreenViewModel: ObservableObject {
    
    @Published var model: TeacherPickerScreenModel = TeacherPickerScreenModel()
    
    var teacherText: String {
        get {
            model.teacherText
        }
        set(newValue) {
            model.teacherText = newValue
        }
    }
    
}
