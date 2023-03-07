//
//  ConvertDateToHourMinute.swift
//  Schedule
//
//  Created by admin on 07.03.2023.
//

import Foundation

class ConvertDateToHourMinute {
    
    func convert(_ timeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        if let date = dateFormatter.date(from: timeString) {
            dateFormatter.dateFormat = "H:mm"
            return dateFormatter.string(from: date).replacingOccurrences(of: "^0", with: "", options: .regularExpression)
        } else {
            return ""
        }
    }
    
}
