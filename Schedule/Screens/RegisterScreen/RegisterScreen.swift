//
//  RegisterScreen.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct RegisterScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: RegisterScreenViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Create Account")
                    .font(.custom("Poppins-semibold", size: 21))
                    .foregroundColor(.dayOfMonthColor)
                Spacer().frame(height: 8)
                Text("Check out your schedule everyday!")
                    .font(.custom("Poppins-regular", size: 14))
                    .foregroundColor(.grayColor)
                Group {
                    Group {
                        Spacer().frame(height: 40)
                        TextFieldView(header: "Full Name", text: $viewModel.fullName, placeholderText: "Enter your full name", isSecuredField: false)
                            .disabled(viewModel.teacher.name != nil)
                        Spacer().frame(height: 20)
                        TextFieldView(header: "Email Address", text: $viewModel.emailText, placeholderText: "Enter your email", isSecuredField: false)
                        Spacer().frame(height: 20)
                        TextFieldView(header: "Password", text: $viewModel.passwordText, placeholderText: "Enter your password", isSecuredField: true)
                        Spacer().frame(height: 20)
                        TextFieldView(header: "Confirm Password", text: $viewModel.confirmPasswordText, placeholderText: "Confirm your password", isSecuredField: true)
                        Spacer().frame(height: 20)
                    }
                    Group {
                        HStack {
                            Rectangle().fill(Color.softGray).frame(height: 1)
                            Spacer().frame(width: 20)
                            Text("Choose your role")
                                .fixedSize()
                                .foregroundColor(.dayOfMonthColor)
                                .font(.custom("Poppins-Regular", size: 13))
                            Spacer().frame(width: 20)
                            Rectangle().fill(Color.softGray).frame(height: 1)
                        }
                        Spacer().frame(height: 30)
                        HStack(spacing: 0) {
                            NavigationLink(destination: GroupPickerScreen(viewModel: generalViewModel.groupPickerScreenViewModel, editingProfileMode: false, goToNextScreen: false, isGuest: false).navigationBarBackButtonHidden(true)) {
                                UnfilledButton(text: "Student")
                                    .background(viewModel.selectedRole == 0 ? Color.todayTextBackgroundColor : Color.white)
                            }
                            Spacer()
                            NavigationLink(destination: TeacherPickerScreen(viewModel: generalViewModel.teacherPickerScreenViewModel, editingProfileMode: false, isGuest: false, goToNextScreen: false).navigationBarBackButtonHidden(true)) {
                                UnfilledButton(text: "Teacher")
                                    .background(viewModel.selectedRole == 1 ? Color.todayTextBackgroundColor : Color.white)
                            }
                        }
                    }
                    Spacer().frame(height: 10)
                    switch viewModel.selectedRole {
                    case 0:
                        Text("Group: \(viewModel.group.name ?? "")")
                            .foregroundColor(.dayOfMonthColor)
                            .font(.custom("Poppins-Medium", size: 14))
                            .frame(height: 40)
                    case 1:
                        Text("*Your email domain must be yandex.ru to be a teacher")
                            .foregroundColor(.dayOfMonthColor)
                            .font(.custom("Poppins-Medium", size: 14))
                            .frame(height: 40)
                    default:
                        Spacer().frame(height: 40)
                    }
                    Spacer().frame(height: 10)
                }
                Group {
                    FilledButton(text: "Sign up") {
                        viewModel.register { success in
                            if(success) {
                                print("Succ register")
                                if(!(viewModel.group.name?.isEmpty ?? true)) {
                                    print("group", viewModel.group.id)
                                    viewModel.setGroup(group: viewModel.group.id) { success in
                                        if(success) {
                                            viewModel.toggleValidationStatusClosure(success)
                                            generalViewModel.mainScreenId += 1
                                            generalViewModel.scheduleType = .group
                                            UserStorage.shared.saveGroupId(groupId: viewModel.group.id)
                                            presentationMode.wrappedValue.dismiss()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                viewModel.showProgressView = false
                                            }
                                        }
                                    }
                                }
                                else {
                                    print("teacher", viewModel.teacher.id)
                                    generalViewModel.scheduleType = .teacher
                                    UserStorage.shared.saveTeacherId(teacherId: viewModel.teacher.id)
                                    presentationMode.wrappedValue.dismiss()
                                    viewModel.toggleValidationStatusClosure(success)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {
                                        viewModel.showProgressView = false
                                    }
                                }
                            }
                            else {
                                print("Error")
                                viewModel.showProgressView = false
                            }
                        }
                    }
                    .alert(item: $viewModel.error) { error in
                        Alert(title: Text("Invalid Registration"), message: Text(error.errorDescription))
                    }
                }
                Spacer()
                HStack(alignment: .center, spacing: 0) {
                    Text("Already have an account? ")
                        .foregroundColor(.grayColor)
                    
                    Text("Login")
                        .foregroundColor(.darkGreenColor)
                        .onTapGesture {
                            dismiss()
                        }
                }
                .frame(maxWidth: .infinity)
                .font(.custom("Poppins-Regular", size: 14))
            }
            .padding(.top, 20)
            .padding(20)
            if(viewModel.showProgressView) {
                Rectangle().fill(Color.white.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        }
    }
    
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen(viewModel: RegisterScreenViewModel(toggleValidationStatusClosure: { success in
            GeneralViewModel().isValidated = success
        }))
        .environmentObject(GeneralViewModel())
    }
}
