//
//  EditProfileScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class EditProfileScreenViewModel: ObservableObject {
    
    @Published private var model: EditProfileScreenModel = EditProfileScreenModel()
    
    let toggleValidationStatusClosure: (Bool) -> Void
    
    init(toggleValidationStatusClosure: @escaping (Bool) -> Void) {
        self.toggleValidationStatusClosure = toggleValidationStatusClosure
    }
    
    var emailText: String {
        get {
            model.emailText
        }
        set(newValue) {
            model.emailText = newValue
        }
    }
    
    var role: Int {
        get {
            model.role
        }
        set(newValue) {
            model.role = newValue
        }
    }
    
}
