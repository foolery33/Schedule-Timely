//
//  GroupPickerScreenViewModel.swift
//  Schedule
//
//  Created by admin on 24.02.2023.
//

import SwiftUI

class GroupPickerScreenViewModel: ObservableObject {
    
    @Published var model: GroupPickerScreenModel = GroupPickerScreenModel()
    
    var groupText: String {
        get {
            model.groupText
        }
        set(newValue) {
            model.groupText = newValue
        }
    }
    
}
