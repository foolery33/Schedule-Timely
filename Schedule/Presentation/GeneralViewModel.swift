//
//  GeneralViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class GeneralViewModel: ObservableObject {
    
    // MARK: Login Screen
    @Published var loginScreenViewModel: LoginScreenViewModel = LoginScreenViewModel()
    @Published var rememberPassword: Bool = false
    
    // MARK: Register Screen
    @Published var registerScreenViewModel: RegisterScreenViewModel = RegisterScreenViewModel()
    
    // MARK: Group Picker Screen
    @Published var groupPickerScreenViewModel: GroupPickerScreenViewModel = GroupPickerScreenViewModel()
    
    // MARK: Teacher Picker Screen
    @Published var teacherPickerScreenViewModel: TeacherPickerScreenViewModel = TeacherPickerScreenViewModel()
    
    // MARK: Main Screen
    @Published var mainScreenViewModel: MainScreenViewModel = MainScreenViewModel()
    @Published var isAscendingOrder: Bool = true
    @Published var currentDayIndex: Int = MainScreenViewModel().weekdayIndex(for: Date())
    
    // MARK: Profile Screen
    @Published var profileScreenViewModel: ProfileScreenViewModel = ProfileScreenViewModel()
    @Published var showAvatarAlert: Bool = false
    @Published var showEditInfo: Bool = false
    
    // MARK: Edit Profile Screen
    @Published var editProfileScreenViewModel: EditProfileScreenViewModel = EditProfileScreenViewModel()
    
}
