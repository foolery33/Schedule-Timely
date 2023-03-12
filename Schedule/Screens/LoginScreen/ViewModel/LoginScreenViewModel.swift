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
            switch result {
            case .success(let data):
                if let groupId = data.group?.id {
                    print("groupId", groupId)
                    UserStorage.shared.saveGroupId(groupId: groupId)
                    completion(("group", groupId))
                    return
                }
                if let teacherId = data.teacher?.id {
                    print("teacherId", teacherId)
                    UserStorage.shared.saveTeacherId(teacherId: teacherId)
                    completion(("teacher", teacherId))
                    return
                }
            case .failure(let authError):
                showProgressView = false
                error = authError
                completion(("", ""))
            }
        }
    }
    
}

