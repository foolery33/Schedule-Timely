//
//  Response.swift
//  Schedule
//
//  Created by admin on 04.03.2023.
//

import Foundation

struct ResponseModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
    
    init(status: String? = nil, message: String? = nil) {
        self.status = status
        self.message = message
    }
    
    let status: String?
    let message: String?
    
}
