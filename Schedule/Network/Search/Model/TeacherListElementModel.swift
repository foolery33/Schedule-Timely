//
//  TeacherListModel.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation

struct TeacherListElementModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(id: String, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    var id: String
    let name: String?
    
}
