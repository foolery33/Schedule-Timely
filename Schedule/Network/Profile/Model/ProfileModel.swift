//
//  ProfileModel.swift
//  Schedule
//
//  Created by admin on 04.03.2023.
//

import Foundation

struct ProfileModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
//        case isEmailConfirmed = "isEmailConfirmed"
        case group = "group"
        case teacher = "teacher"
        case roles = "roles"
    }
    
//    init(fullName: String? = nil, userName: String? = nil, email: String? = nil, isEmailConfirmed: Bool, group: GroupModel, teacher: TeacherModel, role: [String?] = [nil]) {
//        self.fullName = fullName
//        self.userName = userName
//        self.email = email
//        self.isEmailConfirmed = isEmailConfirmed
//        self.group = group
//        self.teacher = teacher
//        self.role = role
//    }
  
    init(email: String? = nil, group: GroupModel? = nil, teacher: TeacherModel? = nil, roles: [String]? = nil) {
        self.email = email
        self.group = group
        self.teacher = teacher
        self.roles = roles
    }
    
//    let fullName: String?
//    let userName: String?
    let email: String?
//    let isEmailConfirmed: Bool
    let group: GroupModel?
    let teacher: TeacherModel?
    let roles: [String]?
//    let role: [String?]
    
}
