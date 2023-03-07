//
//  GeneralViewModel.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

class GeneralViewModel: ObservableObject {
    
    init() {
        initViewModels()
    }
    
    @Published var isValidated: Bool = !UserStorage.shared.fetchAccessToken().isEmpty
    
    // MARK: Login Screen
    @Published var loginScreenViewModel: LoginScreenViewModel!
    
    // MARK: Register Screen
    @Published var registerScreenViewModel: RegisterScreenViewModel!
    
    // MARK: Profile Screen
    @Published var profileScreenViewModel: ProfileScreenViewModel!
    
    // MARK: Group Picker Screen
    @Published var groupPickerScreenViewModel: GroupPickerScreenViewModel!
    
    // MARK: Teacher Picker Screen
    @Published var teacherPickerScreenViewModel: TeacherPickerScreenViewModel!
    
    // MARK: Main Screen
    @Published var mainScreenViewModel: MainScreenViewModel!
//    @Published var currentDayIndex: Int = MainScreenViewModel().weekdayIndex(for: Date())
//    @Published var daysOfWeek: [Date] = MainScreenViewModel().getDaysOfWeek(for: Date())
    
    @Published var showEditInfo: Bool = false
    
    // MARK: Edit Profile Screen
    @Published var editProfileScreenViewModel: EditProfileScreenViewModel!
    
//    func updateCurrentDayIndex(on newValue: Date) {
//        self.currentDayIndex = MainScreenViewModel().weekdayIndex(for: newValue)
//        objectWillChange.send()
//    }
    
    func clearViewModels() {
        self.loginScreenViewModel = LoginScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
        self.registerScreenViewModel = RegisterScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
        self.mainScreenViewModel = MainScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
        self.profileScreenViewModel = ProfileScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
        self.editProfileScreenViewModel = EditProfileScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
        self.groupPickerScreenViewModel = GroupPickerScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
        self.teacherPickerScreenViewModel = TeacherPickerScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
    }
    
    func initViewModels() {
        loginScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
        registerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
        mainScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
        loginScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
        profileScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
        editProfileScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
        groupPickerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
        teacherPickerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isValidated = result
                }
            }
        )
    }
    
}
