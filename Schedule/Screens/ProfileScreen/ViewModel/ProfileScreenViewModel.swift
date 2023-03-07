//
//  ProfileScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class ProfileScreenViewModel: LoadingDataClass {
    
    @Published private var model: ProfileScreenModel = ProfileScreenModel()
    
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
    
    var role: String {
        get {
            model.role
        }
        set(newValue) {
            model.role = newValue
        }
    }
    
    var additionalInfo: String {
        get {
            model.additionalInfo
        }
        set(newValue) {
            model.additionalInfo = newValue
        }
    }
    
    var avatarLink: String {
        get {
            model.avatarLink
        }
        set(newValue) {
            model.avatarLink = newValue
        }
    }
    
    var showAvatarAlert: Bool {
        get {
            model.showAvatarAlert
        }
        set(newValue) {
            model.showAvatarAlert = newValue
        }
    }
    
    @Published var showEditInfo: Bool = false
    
    func getProfile(completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        ProfileViewModel.shared.getProfile() { [unowned self] (result: Result<ProfileModel, AppError>) in
            showProgressView = false
            showContent = true
            switch result {
            case .success(let profile):
                avatarLink = profile.avatarLink ?? ""
                fullName = profile.fullName ?? ""
                emailText = profile.email ?? ""
                role = (profile.roles?.contains("Teacher") ?? false ? "Teacher" : "Student")
                additionalInfo = (role == "Teacher") ? "Teacher" : ((role == "Student") ? ("Group: \(profile.group?.name ?? "")") : "")
                completion(true)
            case .failure(let error):
                self.error = error
                completion(false)
            }
        }
    }
    
    func setAvatar(completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        ProfileViewModel.shared.setAvatar(avatarLink: self.avatarLink) { [unowned self] (result: Result<String, AppError>) in
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
    
    func logout(completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        AuthenticationViewModel.shared.logout() { [unowned self] (result: Result<Bool, AppError>) in
            switch result {
            case .success:
                completion(true)
            case .failure(let authError):
                print("failure")
                print(authError)
                error = authError
                if(authError == AppError.authenticationError(.unauthorized)) {
                    completion(true)
                }
                else {
                    completion(false)
                }
            }
        }
    }
    
}
