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
    
    // MARK: Classroom Picker Screen
    @Published var classroomPickerScreenViewModel: ClassroomPickerScreenViewModel!
    
    // MARK: Main Screen
    @Published var mainScreenViewModel: MainScreenViewModel!
//    @Published var currentDayIndex: Int = MainScreenViewModel().weekdayIndex(for: Date())
//    @Published var daysOfWeek: [Date] = MainScreenViewModel().getDaysOfWeek(for: Date())
    
    // MARK: About Subject Screen
    @Published var aboutSubjectScreenViewModel: AboutSubjectScrenViewModel!
    
    @Published var showEditInfo: Bool = false
    
    // MARK: Edit Profile Screen
    @Published var editProfileScreenViewModel: EditProfileScreenViewModel!
    
//    func updateCurrentDayIndex(on newValue: Date) {
//        self.currentDayIndex = MainScreenViewModel().weekdayIndex(for: newValue)
//        objectWillChange.send()
//    }
    
    @Published var rootId: UUID = UUID()
    
    // Если пользователь уже зашёл в аккаунт, то для него id у MainScreen == 0
    @Published var mainScreenId: Int = UserStorage.shared.fetchAccessToken().isEmpty ? -1 : 0
    
    // Взависимости от id экрана будет даваться кортеж из типа расписания и id расписания. Эти данные нужны, чтобы отправлять запросы на сервер на получение расписания
    var path: [Int: (ScheduleType, String)] = [:]
    
    @Published var scheduleType: ScheduleType = GetScheduleType().getScheduleType()
    
    @Published var groupId: String = UserStorage.shared.fetchGroupId()
    @Published var teacherId: String = UserStorage.shared.fetchTeacherId()
    @Published var classroomId: String = UserStorage.shared.fetchClassroomId()
    @Published var changedProfile: Bool = false
    
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
        self.classroomPickerScreenViewModel = ClassroomPickerScreenViewModel(toggleValidationStatusClosure: { success in
            self.isValidated = success
        })
        self.aboutSubjectScreenViewModel = AboutSubjectScrenViewModel()
        self.teacherId = ""
        self.groupId = ""
        self.showEditInfo = false
        self.mainScreenId = -1
        self.path = [:]
    }
    
    func getMainScreenViewModel() -> MainScreenViewModel {
        return MainScreenViewModel(toggleValidationStatusClosure: { result in
            self.isValidated = result
        })
    }
    
    func initViewModels() {
        loginScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        registerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        mainScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        loginScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        profileScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        editProfileScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        groupPickerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        teacherPickerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        classroomPickerScreenViewModel = .init(
            toggleValidationStatusClosure: { result in
                self.isValidated = result
            }
        )
        aboutSubjectScreenViewModel = AboutSubjectScrenViewModel()
    }
    
}
