//
//  TeacherModel.swift
//  Schedule
//
//  Created by admin on 04.03.2023.
//

import Foundation

struct TeacherModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    let id: String?
    let name: String
    
}
