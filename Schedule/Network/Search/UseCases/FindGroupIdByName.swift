//
//  FindGroupIdByName.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation

class FindGroupIdByName {
    
    func find(name: String, in groupList: [GroupListElementModel]) -> String {
        for i in 0..<groupList.count {
            if(groupList[i].name == name) {
                return groupList[i].id
            }
        }
        return ""
    }
    
}
