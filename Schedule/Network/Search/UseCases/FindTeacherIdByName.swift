//
//  FindTeacherIdByName.swift
//  Schedule
//
//  Created by admin on 07.03.2023.
//

import Foundation

class FindTeacherIdByName {
    
    func find(name: String, in teacherList: [TeacherListElementModel]) -> String {
        for i in 0..<teacherList.count {
            if(teacherList[i].name == name) {
                return teacherList[i].id
            }
        }
        return ""
    }
    
}
