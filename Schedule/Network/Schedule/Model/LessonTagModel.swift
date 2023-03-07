//
//  LessonTagModel.swift
//  Schedule
//
//  Created by admin on 06.03.2023.
//

import Foundation

struct LessonTagModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
    
    init(name: String, id: String? = nil) {
        self.name = name
        self.id = id
    }
    
    let name: String
    let id: String?
    
}
