//
//  GroupModel.swift
//  Schedule
//
//  Created by admin on 04.03.2023.
//

import Foundation

struct GroupModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isDeleted = "isDeleted"
    }
    
    init(id: String, name: String? = nil, isDeleted: Bool) {
        self.id = id
        self.name = name
        self.isDeleted = isDeleted
    }
    
    let id: String
    let name: String?
    let isDeleted: Bool
    
}
