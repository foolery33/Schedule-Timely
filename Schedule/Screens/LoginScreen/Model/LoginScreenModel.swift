//
//  LoginScreenModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import Foundation

struct LoginScreenModel {
    
    var emailText: String = ""
    var passwordText: String = ""
    var isValidated: Bool = false
    var rememberPassword: Bool = true
    
    mutating func setValidated() -> Void {
        isValidated.toggle()
    }
    mutating func setRememberPassword() -> Void {
        rememberPassword.toggle()
    }
    
}
