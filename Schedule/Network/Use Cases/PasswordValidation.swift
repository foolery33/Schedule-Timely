//
//  PasswordValidation.swift
//  Schedule
//
//  Created by admin on 02.03.2023.
//

import Foundation

class PasswordValidation {
    
    let lowAlphabet = "abcdefghjklmnopqrstuvwxyz"
    let upAlphabet = "ABCDEFGHIJKLMNOPQRTSUVWXYZ"
    let digits = "1234567890"
    let alphanumeric = "-_!@#№$%^&?*+=(){}[]<>~"
    
    var flagLow = true
    var flagUp = true
    var flagDigits = true
    var flagAlphanumeric = true
    
    func isValidPassword(_ password: String) -> AuthenticationViewModel.AuthenticationError? {
        
        if (password.count < 8) {
            return AuthenticationViewModel.AuthenticationError.shortPassword
        }
        
        else if (password.count > 64) {
            return AuthenticationViewModel.AuthenticationError.longPassword
        }
        
        for char in upAlphabet {
            if(password.contains(char)) {
                flagUp = true
                break
            }
            flagUp = false
        }
        if(!flagUp) {
            return AuthenticationViewModel.AuthenticationError.noUppercaseSymbol
        }
        
        for char in lowAlphabet {
            if(password.contains(char)) {
                flagLow = true
                break
            }
            flagLow = false
        }
        if(!flagLow) {
            return AuthenticationViewModel.AuthenticationError.noLowercaseSymbol
        }

        for char in alphanumeric {
            if(password.contains(char)) {
                flagAlphanumeric = true
                break
            }
            flagAlphanumeric = false
        }
        if(!flagAlphanumeric) {
            return AuthenticationViewModel.AuthenticationError.noNonAlphanumericSymbol
        }
        
        return nil
    }
    
}
