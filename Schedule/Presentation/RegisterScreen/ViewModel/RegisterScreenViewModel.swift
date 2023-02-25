//
//  RegisterScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class RegisterScreenViewModel: ObservableObject {

    @Published private var model: RegisterScreenModel = RegisterScreenModel()
    
    var emailText: String {
        get {
            model.emailText
        }
        set(newValue) {
            model.emailText = newValue
        }
    }
    
    var passwordText: String {
        get {
            model.passwordText
        }
        set(newValue) {
            model.passwordText = newValue
        }
    }
    
    var confirmPasswordText: String {
        get {
            model.confirmPasswordText
        }
        set(newValue) {
            model.confirmPasswordText = newValue
        }
    }
    
}
