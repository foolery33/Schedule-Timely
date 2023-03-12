//
//  UsernameValidation.swift
//  Schedule
//
//  Created by admin on 03.03.2023.
//

import Foundation

class FullNameValidation {
    
    func isValidUsername(_ fullName: String) -> Bool {
        
        let nameComponents = fullName.components(separatedBy: .whitespaces)
        
        // Проверяем, что ФИО состоит из 2-3 слов
        guard nameComponents.count >= 2 && nameComponents.count <= 3 else {
            return false
        }
        
        let nameRegex = "^[a-zA-Zа-яА-ЯёЁ\\s]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        
        // Проверяем, что все слова начинаются с заглавной буквы и содержат только латинские, кириллические символы или пробелы
        for component in nameComponents {
            guard let firstLetter = component.first,
                  firstLetter.isUppercase,
                  namePredicate.evaluate(with: component) else {
                return false
            }
        }
        
        return true
    }
}
