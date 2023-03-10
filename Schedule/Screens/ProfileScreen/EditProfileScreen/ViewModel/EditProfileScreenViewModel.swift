//
//  EditProfileScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class EditProfileScreenViewModel: LoadingDataClass {
    
    @Published private var model: EditProfileScreenModel = EditProfileScreenModel()
    
    let toggleValidationStatusClosure: (Bool) -> Void
    
    init(toggleValidationStatusClosure: @escaping (Bool) -> Void) {
        self.toggleValidationStatusClosure = toggleValidationStatusClosure
    }
    
    var fullNameText: String {
        get {
            model.fullNameText
        }
        set(newValue) {
            model.fullNameText = newValue
        }
    }
    
    var selectedRole: Int {
        get {
            model.selectedRole
        }
        set(newValue) {
            model.selectedRole = newValue
        }
    }
    
    var group: GroupListElementModel {
        get {
            model.group
        }
        set(newValue) {
            model.group = newValue
        }
    }
    
    var teacher: TeacherListElementModel {
        get {
            model.teacher
        }
        set(newValue) {
            model.teacher = newValue
        }
    }
    
    func changeProfile(fullName: String, completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
        }
        ProfileViewModel.shared.changeProfile(fullName: fullNameText) { [unowned self] (result: Result<Bool, AppError>) in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self.error = error
                if(self.error == AppError.profileError(.unauthorized)) {
                    self.isUnauthorized = true
                }
                print(self.error)
                completion(false)
            }
        }
    }
    
}
