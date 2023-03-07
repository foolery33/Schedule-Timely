//
//  TokenResponseModel.swift
//  Schedule
//
//  Created by admin on 28.02.2023.
//

import Foundation

struct TokenResponseModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case email = "email"
        case role = "role"
        case group = "group"
        case teacher = "teacher"
    }
    
    init (token: String? = nil, email: String? = nil, role: [String]? = nil, group: GroupListElementModel? = nil, teacher: TeacherListElementModel? = nil) {
        self.token = token
        self.email = email
        self.role = role
        self.group = group
        self.teacher = teacher
    }
    
    let token: String?
    let email: String?
    let role: [String]?
    let group: GroupListElementModel?
    let teacher: TeacherListElementModel?
    
}
