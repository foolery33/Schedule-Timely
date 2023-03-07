//
//  TimeIntervalModel.swift
//  Schedule
//
//  Created by admin on 06.03.2023.
//

import Foundation

struct TimeIntervalModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case startTime = "startTime"
        case endTime = "endTime"
        case id = "id"
    }
    
    init(startTime: String, endTime: String, id: String? = nil) {
        self.startTime = startTime
        self.endTime = endTime
        self.id = id
    }
    
    let startTime: String
    let endTime: String
    let id: String?
    
}
