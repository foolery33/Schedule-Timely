//
//  ProfileScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class ProfileScreenViewModel: ObservableObject {
    
    @Published private var model: ProfileScreenModel = ProfileScreenModel()
    
    var emailText: String {
        get {
            model.emailText
        }
        set(newValue) {
            model.emailText = newValue
        }
    }
    
    var role: Int {
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
    
    func toggleEditInfo() -> Void {
        self.showEditInfo = true
        objectWillChange.send()
    }
    
}
