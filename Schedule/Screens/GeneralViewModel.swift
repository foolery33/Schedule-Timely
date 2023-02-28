//
//  GeneralViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class GeneralViewModel: ObservableObject {
    
    @Published var isValidated: Bool = false
    
    // MARK: Login Screen
    @Published var loginScreenViewModel: LoginScreenViewModel!
    
    init() {
        loginScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 1)) {
                    self.isValidated = result
                }
            }
        )
    }
    
    // MARK: Register Screen
    @Published var registerScreenViewModel: RegisterScreenViewModel = RegisterScreenViewModel()
    
    // MARK: Group Picker Screen
    @Published var groupPickerScreenViewModel: GroupPickerScreenViewModel = GroupPickerScreenViewModel()
    
    // MARK: Teacher Picker Screen
    @Published var teacherPickerScreenViewModel: TeacherPickerScreenViewModel = TeacherPickerScreenViewModel()
    
    // MARK: Main Screen
    @Published var mainScreenViewModel: MainScreenViewModel = MainScreenViewModel()
//    @Published var currentDayIndex: Int = MainScreenViewModel().weekdayIndex(for: Date())
//    @Published var daysOfWeek: [Date] = MainScreenViewModel().getDaysOfWeek(for: Date())
    
    // MARK: Profile Screen
    @Published var profileScreenViewModel: ProfileScreenViewModel = ProfileScreenViewModel()
//    @Published var showAvatarAlert: Bool = false
    @Published var showEditInfo: Bool = false
    
    // MARK: Edit Profile Screen
    @Published var editProfileScreenViewModel: EditProfileScreenViewModel = EditProfileScreenViewModel()
    
//    func updateCurrentDayIndex(on newValue: Date) {
//        self.currentDayIndex = MainScreenViewModel().weekdayIndex(for: newValue)
//        objectWillChange.send()
//    }
    
}
