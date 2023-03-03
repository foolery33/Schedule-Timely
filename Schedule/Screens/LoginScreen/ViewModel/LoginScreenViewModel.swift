//
//  LoginScreenViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class LoginScreenViewModel: ObservableObject {
    
    @Published private var model: LoginScreenModel = LoginScreenModel()
    
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
    
    @Published var showProgressView = false
    @Published var error: AuthenticationViewModel.AuthenticationError?
    
    var loginDisabled: Bool {
        emailText.isEmpty || passwordText.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        AuthenticationViewModel.shared.login(email: emailText, password: passwordText) { [unowned self] (result: Result<Bool, AuthenticationViewModel.AuthenticationError>) in
            showProgressView = false
            switch result {
            case .success:
                completion(true)
            case .failure(let authError):
                error = authError
                completion(false)
            }
        }
    }
    
}

