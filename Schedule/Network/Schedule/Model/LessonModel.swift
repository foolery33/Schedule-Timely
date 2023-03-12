//
//  LessonModel.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation

struct LessonModel: Decodable, Equatable {
    static func == (lhs: LessonModel, rhs: LessonModel) -> Bool {
        lhs.id == rhs.id
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case tag = "tag"
        case group = "group"
        case teacher = "teacher"
        case timeInterval = "timeInterval"
        case classroom = "classroom"
        case date = "date"
        case chainId = "chainId"
        
    }
    
    init(id: String? = nil, name: LessonNameModel, tag: LessonTagModel, group: [GroupModel], teacher: TeacherModel, timeInterval: TimeIntervalModel, classroom: ClassroomModel, date: String, chainId: String? = nil) {
        self.id = id
        self.name = name
        self.tag = tag
        self.group = group
        self.teacher = teacher
        self.timeInterval = timeInterval
        self.classroom = classroom
        self.date = date
        self.chainId = chainId
    }
    
    let id: String?
    let name: LessonNameModel
    let tag: LessonTagModel
    let group: [GroupModel]
    let teacher: TeacherModel
    let timeInterval: TimeIntervalModel
    let classroom: ClassroomModel
    let date: String
    let chainId: String?
    
}
