//
//  LoginScreenViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class LoginScreenViewModel: LoadingDataClass {
    
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
    
    func login(completion: @escaping ((String, String)) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        AuthenticationViewModel.shared.login(email: emailText, password: passwordText) { [unowned self] (result: Result<TokenResponseModel, AppError>) in
            showProgressView = false
            switch result {
            case .success(let data):
                if let teacherId = data.teacher?.id {
                    completion(("teacher", teacherId))
                    return
                }
                if let groupId = data.group?.id {
                    completion(("group", groupId))
                    return
                }
            case .failure(let authError):
                error = authError
                print("Error: ", error!.localizedDescription)
                completion(("", ""))
            }
        }
    }
    
}

