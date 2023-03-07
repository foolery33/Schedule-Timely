//
//  GroupPickerScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class GroupPickerScreenViewModel: LoadingDataClass {
    
    @Published var model: GroupPickerScreenModel = GroupPickerScreenModel()
    
    let toggleValidationStatusClosure: (Bool) -> Void
    
    init(toggleValidationStatusClosure: @escaping (Bool) -> Void) {
        self.toggleValidationStatusClosure = toggleValidationStatusClosure
    }
    
    var groupList: [GroupListElementModel] {
        get {
            model.groupList
        }
        set(newValue) {
            model.groupList = newValue
        }
    }
    
    var groupText: String {
        get {
            model.groupText
        }
        set(newValue) {
            model.groupText = newValue
        }
    }
    
    func getGroupList(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        SearchViewModel.shared.getGroupList() { [unowned self] (result: Result<[GroupListElementModel], AppError>) in
            showProgressView = false
            showContent = true
            switch result {
            case .success(let groups):
                groupList = groups
                print(groupList)
                completion(true)
            case .failure(let errorData):
                error = errorData
                completion(false)
            }
        }
    }
    
}
