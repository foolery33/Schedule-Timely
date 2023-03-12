//
//  RegisterScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class RegisterScreenViewModel: LoadingDataClass {

    @Published private var model: RegisterScreenModel = RegisterScreenModel()
    
    let toggleValidationStatusClosure: (Bool) -> Void
    
    init(toggleValidationStatusClosure: @escaping (Bool) -> Void) {
        self.toggleValidationStatusClosure = toggleValidationStatusClosure
    }
    
    var fullName: String {
        get {
            model.fullName
        }
        set(newValue) {
            model.fullName = newValue
        }
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
    
    var group: GroupListElementModel {
        get {
            model.group
        }
        set(newValue) {
            model.group = newValue
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
    
    var teacher: TeacherListElementModel {
        get {
            model.teacher
        }
        set(newValue) {
            model.teacher = newValue
        }
    }
    
    func register(completion: @escaping (Bool) -> Void) {
        
        if(selectedRole == -1) {
            error = .authenticationError(.noCredentials)
            completion(false)
            return
        }
        if(!emailText.contains("@yandex.ru") && selectedRole == 1) {
            error = .authenticationError(.notTeacherEmail)
            completion(false)
            return
        }
        if(emailText.contains("@yandex.ru") && selectedRole == 0) {
            error = .authenticationError(.studentCantBeTeacher)
            completion(false)
            return
        }
        
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        AuthenticationViewModel.shared.register(fullName: fullName, email: emailText, password: passwordText, confirmPassword: confirmPasswordText) { [unowned self] (result: Result<Bool, AppError>) in
            switch result {
            case .success:
                print("Succ register")
                completion(true)
            case .failure(let authError):
                error = authError
                completion(false)
            }
        }
    }
    
    func setGroup(group: String, completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        AuthenticationViewModel.shared.setGroup(group: group) { [unowned self] (result: Result<Bool, AppError>) in
            switch result {
            case .success:
                UserStorage.shared.saveGroupId(groupId: group)
                completion(true)
            case .failure(let authError):
                error = authError
                completion(false)
            }
        }
    }
    
}
