//
//  ProfileModel.swift
//  Schedule
//
//  Created by admin on 04.03.2023.
//

import Foundation

struct ProfileModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case email = "email"
//        case isEmailConfirmed = "isEmailConfirmed"
        case group = "group"
        case teacher = "teacher"
        case roles = "roles"
        case avatarLink = "avatarLink"
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
  
    init(fullName: String? = nil, email: String? = nil, group: GroupModel? = nil, teacher: TeacherModel? = nil, roles: [String]? = nil, avatarLink: String? = nil) {
        self.fullName = fullName
        self.email = email
        self.group = group
        self.teacher = teacher
        self.roles = roles
        self.avatarLink = avatarLink
    }
    
    let fullName: String?
//    let userName: String?
    let email: String?
//    let isEmailConfirmed: Bool
    let group: GroupModel?
    let teacher: TeacherModel?
    let roles: [String]?
    let avatarLink: String?
//    let role: [String?]
    
}
