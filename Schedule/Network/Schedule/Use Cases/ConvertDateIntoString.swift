//
//  ConvertDateIntoString.swift
//  Schedule
//
//  Created by admin on 06.03.2023.
//

import Foundation

class ConvertDateIntoString {
    
    func convert(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    
}
