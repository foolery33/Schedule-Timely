//
//  GetScheduleType.swift
//  Schedule
//
//  Created by admin on 09.03.2023.
//

import Foundation

class GetScheduleType {
    
    func getScheduleType() -> ScheduleType {
        if(!UserStorage.shared.fetchGroupId().isEmpty) {
            return ScheduleType.group
        }
        if(!UserStorage.shared.fetchTeacherId().isEmpty) {
            return ScheduleType.teacher
        }
        if(!UserStorage.shared.fetchClassroomId().isEmpty) {
            return ScheduleType.classroom
        }
        return ScheduleType.group
    }
    
}


enum ScheduleType {
    case group
    case teacher
    case classroom
}
