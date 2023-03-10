//
//  GroupPickerScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class ClassroomPickerScreenViewModel: LoadingDataClass {
    
    @Published var model: ClassroomPickerScreenModel = ClassroomPickerScreenModel()
    
    let toggleValidationStatusClosure: (Bool) -> Void
    
    init(toggleValidationStatusClosure: @escaping (Bool) -> Void) {
        self.toggleValidationStatusClosure = toggleValidationStatusClosure
    }
    
    var classroomList: [ClassroomModel] {
        get {
            model.classroomList
        }
        set(newValue) {
            model.classroomList = newValue
        }
    }
    
    var classroomText: String {
        get {
            model.classroomText
        }
        set(newValue) {
            model.classroomText = newValue
        }
    }
    
    func getClassroomList(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        SearchViewModel.shared.getClassroomList() { [unowned self] (result: Result<[ClassroomModel], AppError>) in
            showProgressView = false
            showContent = true
            switch result {
            case .success(let groups):
                classroomList = groups
                print(classroomList)
                completion(true)
            case .failure(let errorData):
                error = errorData
                completion(false)
            }
        }
    }
    
}
