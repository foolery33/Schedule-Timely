//
//  LoginScreenViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class LoginScreenViewModel: ObservableObject {
    
    @Published private var model: LoginScreenModel = LoginScreenModel()
    @Published var rememberPassword: Bool = false
    
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
    
}

