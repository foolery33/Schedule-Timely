//
//  TeacherPickerScreen.swift
//  Schedule
//
//  Created by admin on 19.02.2023.
//

import SwiftUI

struct TeacherPickerScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: TeacherPickerScreenViewModel
    var editingProfileMode: Bool
    @Environment(\.dismiss) var dismiss
    var isGuest: Bool

    var goToNextScreen: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    Image(systemName: "chevron.backward")
                        .padding(.leading, 10)
                        .font(.system(size: 16, weight: .medium))
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                    Text("Teachers")
                        .frame(maxWidth: .infinity)
                        .font(.custom("Poppins-Bold", size: 17))
                }
                .foregroundColor(.dayOfMonthColor)
                Spacer().frame(height: 30)
                SearchingTextField(text: $viewModel.teacherText, header: "Find a teacher by name", placeholderText: "Teacher name")
                    .padding([.leading, .trailing], 20)
                
                Spacer().frame(height: 20)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        Spacer().frame(height: 10)
                        let teacherTextedList = MakeList().makeList(from: viewModel.teacherList)
                        ForEach(viewModel.teacherText.isEmpty ? teacherTextedList : teacherTextedList.filter {$0.contains(viewModel.teacherText)}, id: \.self) { teacher in
                            if(goToNextScreen) {
                                ListRow(text: teacher)
                                    .onTapGesture {
                                        if(isGuest) {
                                            viewModel.toggleValidationStatusClosure(true)
                                        }
                                        generalViewModel.scheduleType = .teacher
                                        generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
                                        generalViewModel.mainScreenId += 1
                                        generalViewModel.mainScreenViewModel.showContent = false
                                        generalViewModel.teacherId = FindTeacherIdByName().find(name: teacher, in: viewModel.teacherList)
                                        print(generalViewModel.teacherId)
                                    }
//                                if(isGuest) {
//                                    NavigationLink(destination: MainScreen(viewModel: generalViewModel.mainScreenViewModel).onAppear {
//                                        generalViewModel.mainScreenId += 1
//                                        generalViewModel.mainScreenViewModel.teacherId = FindTeacherIdByName().find(name: teacher, in: viewModel.teacherList)
//                                        generalViewModel.mainScreenViewModel.showContent = false
//                                        generalViewModel.scheduleType = .teacher
//                                        generalViewModel.resetMainScreenViewModel()
//                                    }.navigationBarBackButtonHidden()) {
//                                        ListRow(text: teacher)
//                                    }
//                                    .buttonStyle(NoHighlightButtonStyle())
//                                }
//                                else {
//                                    ListRow(text: teacher)
//                                        .onTapGesture {
//                                            generalViewModel.scheduleType = .teacher
//                                            generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
//                                            generalViewModel.mainScreenId += 1
//                                            generalViewModel.mainScreenViewModel.showContent = false
//                                            generalViewModel.mainScreenViewModel.teacherId = FindTeacherIdByName().find(name: teacher, in: viewModel.teacherList)
//                                            print(generalViewModel.mainScreenViewModel.teacherId)
//                                        }
//                                }
                            }
                            else {
                                ListRow(text: teacher)
                                    .frame(width: UIScreen.main.bounds.size.width)
                                    .onTapGesture {
                                        if(editingProfileMode) {
                                            // На экран зашли с экрана редактирования профиля
                                            generalViewModel.editProfileScreenViewModel.selectedRole = 1
                                            generalViewModel.editProfileScreenViewModel.teacher.name = teacher
                                            generalViewModel.editProfileScreenViewModel.teacher.id = FindTeacherIdByName().find(name: teacher, in: viewModel.teacherList)
                                            generalViewModel.editProfileScreenViewModel.fullNameText = teacher
                                            print(generalViewModel.editProfileScreenViewModel.fullNameText)
                                        }
                                        else {
                                            // На экран зашли с экрана регистрации
                                            generalViewModel.registerScreenViewModel.selectedRole = 1
                                            generalViewModel.registerScreenViewModel.teacher.name = teacher
                                            generalViewModel.registerScreenViewModel.group = GroupListElementModel(id: "")
                                            generalViewModel.registerScreenViewModel.teacher.id = FindTeacherIdByName().find(name: teacher, in: viewModel.teacherList)
                                            generalViewModel.registerScreenViewModel.fullName = teacher
                                        }
                                        dismiss()
                                    }
                            }
                            
                        }
                        Spacer().frame(height: 20)
                    }
                }
                .background(Color.softWhite)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .edgesIgnoringSafeArea(.bottom)
                .opacity(viewModel.showContent ? 1 : 0)
            }
            .padding([.top, .bottom], 20)
            .edgesIgnoringSafeArea(.bottom)
            if(viewModel.showProgressView) {
                Rectangle().fill(Color.white.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        }
        .onAppear {
            viewModel.getTeacherList { success in
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Loading"), message: Text(error.errorDescription))
        }
    }
}

//struct TeacherPickerScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        TeacherPickerScreen()
//    }
//}
