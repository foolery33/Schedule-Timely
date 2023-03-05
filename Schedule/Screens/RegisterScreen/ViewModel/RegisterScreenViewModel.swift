//
//  RegisterScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class RegisterScreenViewModel: ObservableObject {

    @Published private var model: RegisterScreenModel = RegisterScreenModel()
    
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
    
    var confirmPasswordText: String {
        get {
            model.confirmPasswordText
        }
        set(newValue) {
            model.confirmPasswordText = newValue
        }
    }
    
    @Published var showProgressView = false
    @Published var error: AuthenticationViewModel.AuthenticationError?
    
    func register(completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        AuthenticationViewModel.shared.register(email: emailText, password: passwordText, confirmPassword: confirmPasswordText) { [unowned self] (result: Result<Bool, AuthenticationViewModel.AuthenticationError>) in
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
