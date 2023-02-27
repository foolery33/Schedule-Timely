//
//  LoginScreenViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class LoginScreenViewModel: ObservableObject {
    
    @Published private var model: LoginScreenModel = LoginScreenModel()
//    var rememberPassword: Bool = true
    @Published var isValidated: Bool = false
    
    let toggleValidationStatusClosure: () -> Void

    init(toggleValidationStatusClosure: @escaping () -> Void) {
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
    
    var passwordText: String {
        get {
            model.passwordText
        }
        set(newValue) {
            model.passwordText = newValue
        }
    }
    
    var rememberPassword: Bool {
        get {
            model.rememberPassword
        }
        set(newValue) {
            model.rememberPassword = newValue
        }
    }
    
    func getRememberPassword() -> Bool {
        model.rememberPassword
    }
    
    func setValidated() -> Void {
        model.setValidated()
        self.isValidated = model.isValidated
        objectWillChange.send()
    }
    
    func setRememberPassword() -> Void {
        model.setRememberPassword()
        self.rememberPassword = model.rememberPassword
        objectWillChange.send()
    }
    
}

