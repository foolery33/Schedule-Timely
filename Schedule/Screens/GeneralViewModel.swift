//
//  GeneralViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class GeneralViewModel: ObservableObject {
    
    @Published var isValidated: Bool = !TokenManager.shared.fetchAccessToken().isEmpty
    
    // MARK: Login Screen
    @Published var loginScreenViewModel: LoginScreenViewModel!
    
    // MARK: Register Screen
    @Published var registerScreenViewModel: RegisterScreenViewModel!
    
    // MARK: Profile Screen
    @Published var profileScreenViewModel: ProfileScreenViewModel!
    
    init() {
        registerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 1)) {
                    self.isValidated = result
                }
            }
        )
        loginScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 1)) {
                    self.isValidated = result
                }
            }
        )
        profileScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 1)) {
                    self.isValidated = result
                }
            }
        )
    }
    
    // MARK: Group Picker Screen
    @Published var groupPickerScreenViewModel: GroupPickerScreenViewModel = GroupPickerScreenViewModel()
    
    // MARK: Teacher Picker Screen
    @Published var teacherPickerScreenViewModel: TeacherPickerScreenViewModel = TeacherPickerScreenViewModel()
    
    // MARK: Main Screen
    @Published var mainScreenViewModel: MainScreenViewModel = MainScreenViewModel()
//    @Published var currentDayIndex: Int = MainScreenViewModel().weekdayIndex(for: Date())
//    @Published var daysOfWeek: [Date] = MainScreenViewModel().getDaysOfWeek(for: Date())
    
    @Published var showEditInfo: Bool = false
    
    // MARK: Edit Profile Screen
    @Published var editProfileScreenViewModel: EditProfileScreenViewModel = EditProfileScreenViewModel()
    
//    func updateCurrentDayIndex(on newValue: Date) {
//        self.currentDayIndex = MainScreenViewModel().weekdayIndex(for: newValue)
//        objectWillChange.send()
//    }
    
}
