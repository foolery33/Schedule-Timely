//
//  TeachePickerScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class TeacherPickerScreenViewModel: LoadingDataClass {
    
    @Published var model: TeacherPickerScreenModel = TeacherPickerScreenModel()
    
    let toggleValidationStatusClosure: (Bool) -> Void
    
    init(toggleValidationStatusClosure: @escaping (Bool) -> Void) {
        self.toggleValidationStatusClosure = toggleValidationStatusClosure
    }
    
    var teacherList: [TeacherListElementModel] {
        get {
            model.teacherList
        }
        set(newValue) {
            model.teacherList = newValue
        }
    }
    
    var teacherText: String {
        get {
            model.teacherText
        }
        set(newValue) {
            model.teacherText = newValue
        }
    }
    
    func getTeacherList(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        SearchViewModel.shared.getTeacherList() { [unowned self] (result: Result<[TeacherListElementModel], AppError>) in
            showProgressView = false
            showContent = true
            switch result {
            case .success(let groups):
                teacherList = groups
                print(teacherList)
                completion(true)
            case .failure(let errorData):
                error = errorData
                completion(false)
            }
        }
    }
    
}
