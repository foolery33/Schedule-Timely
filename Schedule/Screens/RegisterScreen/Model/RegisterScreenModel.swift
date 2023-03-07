//
//  RegisterScreenModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import Foundation

struct RegisterScreenModel {
    
    var fullName: String = ""
    var emailText: String = ""
    var passwordText: String = ""
    var confirmPasswordText: String = ""
    var group: GroupListElementModel = GroupListElementModel(id: "")
    var selectedRole: Int = -1
    var teacher: TeacherListElementModel = TeacherListElementModel(id: "")
    
}
