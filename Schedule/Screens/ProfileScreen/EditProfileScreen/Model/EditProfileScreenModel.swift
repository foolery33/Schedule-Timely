//
//  EditProfileScreenModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import Foundation

struct EditProfileScreenModel {
    
    var fullNameText: String = ""
    var selectedRole: Int = -1
    var group: GroupListElementModel = GroupListElementModel(id: "")
    var teacher: TeacherListElementModel = TeacherListElementModel(id: "")
    
}
