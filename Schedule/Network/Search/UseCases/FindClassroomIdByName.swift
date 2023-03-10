//
//  FindClassroomIdByName.swift
//  Schedule
//
//  Created by admin on 09.03.2023.
//

import Foundation

class FindClassroomIdByName {
    
    func find(name: String, in classroomList: [ClassroomModel]) -> String {
        for i in 0..<classroomList.count {
            if(classroomList[i].name == name) {
                return classroomList[i].id ?? ""
            }
        }
        return ""
    }
    
}
