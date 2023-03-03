//
//  UsernameValidation.swift
//  Schedule
//
//  Created by admin on 03.03.2023.
//

import Foundation

class UsernameValidation {
    func isValidUsername(username: String) -> AuthenticationViewModel.AuthenticationError? {
        if ((username.components(separatedBy: " ").count - 1 != 2) ||
            (username.components(separatedBy: " ").count - 1 != 3)) {
            return .invalidName
        }
        for i in 0..<username.components(separatedBy: " ").count {
            if(username.components(separatedBy: " ")[i].count < 2) {
                return .invalidName
            }
        }
        return nil
        
    }
}
