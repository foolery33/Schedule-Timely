//
//  TokenManager.swift
//  Schedule
//
//  Created by admin on 27.02.2023.
//

import Foundation
import SwiftKeychainWrapper

class UserStorage {
    
    static let shared = UserStorage()
    
    func fetchEmail() -> String {
        KeychainWrapper.standard.string(forKey: "email") ?? ""
    }
    func fetchPassword() -> String {
        KeychainWrapper.standard.string(forKey: "password") ?? ""
    }
    func fetchAccessToken() -> String {
        KeychainWrapper.standard.string(forKey: "accessToken") ?? ""
    }
    func fetchGroupId() -> String {
        KeychainWrapper.standard.string(forKey: "groupId") ?? ""
    }
    func fetchTeacherId() -> String {
        KeychainWrapper.standard.string(forKey: "teacherId") ?? ""
    }
    func fetchAvatarLink() -> String {
        KeychainWrapper.standard.string(forKey: "avatarLink") ?? ""
    }
    
    func saveEmail(email: String) -> Void {
        KeychainWrapper.standard.set(email, forKey: "email")
    }
    func savePassword(password: String) -> Void {
        KeychainWrapper.standard.set(password, forKey: "password")
    }
    func saveAccessToken(accessToken: String) -> Void {
        KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
    }
    func saveGroupId(groupId: String) -> Void {
        KeychainWrapper.standard.set(groupId, forKey: "groupId")
    }
    func saveTeacherId(teacherId: String) -> Void {
        KeychainWrapper.standard.set(teacherId, forKey: "teacherId")
    }
    func saveAvatarLink(avatarLink: String) -> Void {
        KeychainWrapper.standard.set(avatarLink, forKey: "avatarLink")
    }
    
    func clearToken() {
        KeychainWrapper.standard.set("", forKey: "accessToken")
    }
    func clearAllData() {
        KeychainWrapper.standard.set("", forKey: "email")
        KeychainWrapper.standard.set("", forKey: "password")
        KeychainWrapper.standard.set("", forKey: "accessToken")
        KeychainWrapper.standard.set("", forKey: "groupId")
        KeychainWrapper.standard.set("", forKey: "teacherId")
        KeychainWrapper.standard.set("", forKey: "avatarLink")
    }
    
    func saveProfileData(email: String, password: String, accessToken: String) {
        KeychainWrapper.standard.set(email, forKey: "email")
        KeychainWrapper.standard.set(password, forKey: "password")
        KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
    }
    
}
