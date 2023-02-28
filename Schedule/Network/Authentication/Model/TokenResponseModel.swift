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
    }
    
    init (token: String? = nil, email: String? = nil, role: [String?] = [nil]) {
        self.token = token
        self.email = email
        self.role = role
    }
    
    let token: String?
    let email: String?
    let role: [String?]
    
}
