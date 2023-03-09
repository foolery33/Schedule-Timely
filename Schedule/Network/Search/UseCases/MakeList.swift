//
//  MakeGroupList.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation

class MakeList {
    
    func makeList(from list: [GroupListElementModel]) -> [String] {
        return list.map { $0.name ?? "" }.sorted(by: { $0 < $1 })
    }
    func makeList(from list: [TeacherListElementModel]) -> [String] {
        return list.map { $0.name ?? "" }.sorted(by: { $0 < $1 })
    }
    func makeList(from list: [ClassroomModel]) -> [String] {
        return list.map { $0.name }.sorted(by: { $0 < $1 })
    }
    
}
