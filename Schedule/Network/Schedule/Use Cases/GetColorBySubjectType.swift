//
//  GetColorBySubjectType.swift
//  Schedule
//
//  Created by admin on 07.03.2023.
//

import Foundation
import SwiftUI

class GetColorBySubjectType {
    
    func getBackgroundColor(subjectType: String) -> Color {
        switch subjectType {
        case "Лекция":
            return Color.lectionColor
        case "Лабораторная":
            return Color.laboratoryColor
        case "Практика":
            return Color.practiseColor
        case "Семинар":
            return Color.seminarColor
        case "Экзамен":
            return Color.examColor
        default:
            return Color.backgroundNotCurrentSubjectColor
        }
    }
    
    func getTextColor(subjectType: String) -> Color {
        switch subjectType {
        case "Лекция":
            return Color.lectionTextColor
        case "Лабораторная":
            return Color.laboratoryTextColor
        case "Практика":
            return Color.practiseTextColor
        case "Семинар":
            return Color.seminarTextColor
        case "Экзамен":
            return Color.examTextColor
        default:
            return Color.dayOfMonthColor
        }
    }
    
}
