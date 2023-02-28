//
//  TokenManager.swift
//  Schedule
//
//  Created by admin on 27.02.2023.
//

import Foundation
import SwiftKeychainWrapper

class TokenManager {
    
    static let shared = TokenManager()
    
    func fetchEmail() -> String {
        KeychainWrapper.standard.string(forKey: "login") ?? ""
    }
    func fetchPassword() -> String {
        KeychainWrapper.standard.string(forKey: "password") ?? ""
    }
    func fetchAccessToken() -> String {
        KeychainWrapper.standard.string(forKey: "accessToken") ?? ""
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
    func clearToken() {
        KeychainWrapper.standard.set("", forKey: "accessToken")
    }
    
    func saveData(email: String, password: String, accessToken: String) {
        KeychainWrapper.standard.set(email, forKey: "email")
        KeychainWrapper.standard.set(password, forKey: "password")
        KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
    }
    
}
