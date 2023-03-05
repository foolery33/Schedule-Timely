//
//  ProfileScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class ProfileScreenViewModel: ObservableObject {
    
    @Published private var model: ProfileScreenModel = ProfileScreenModel()
    
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
    
    var role: String {
        get {
            model.role
        }
        set(newValue) {
            model.role = newValue
        }
    }
    
    var avatarLinkText: String {
        get {
            model.avatarLinkText
        }
        set(newValue) {
            model.avatarLinkText = newValue
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
    
    @Published var showProgressView = false
    @Published var error: AuthenticationViewModel.AuthenticationError?
    
//    func getProfile(completion: @escaping (Bool) -> Void) {
//        withAnimation(.linear(duration: 0.1)) {
//            showProgressView = true
//        }
//        ProfileViewModel.shared.getProfile() { [unowned self] (result: Result<ProfileModel, ProfileViewModel.ProfileError>) in
//            showProgressView = false
//            switch result {
//            case .success(let profile):
//                emailText = profile.email ?? ""
//                role = profile.role[0] ?? "Student"
//            }
//        }
//    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        withAnimation(.linear(duration: 0.1)) {
            showProgressView = true
        }
        AuthenticationViewModel.shared.logout() { [unowned self] (result: Result<Bool, AuthenticationViewModel.AuthenticationError>) in
            switch result {
            case .success:
                completion(true)
            case .failure(let authError):
                print("failure")
                print(authError)
                error = authError
                if(authError == AuthenticationViewModel.AuthenticationError.unauthorized) {
                    print("YES")
                    completion(true)
                }
                else {
                    completion(false)
                }
            }
        }
    }
    
}
