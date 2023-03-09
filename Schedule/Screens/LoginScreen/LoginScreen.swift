//
//  LoginScreen.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: LoginScreenViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Hi, Welcome Back!👋")
                    .font(.custom("Poppins-semibold", size: 21))
                    .foregroundColor(.dayOfMonthColor)
                Spacer().frame(height: 8)
                Text("Hello again, you've been missed!")
                    .font(.custom("Poppins-regular", size: 14))
                    .foregroundColor(.grayColor)
                Group {
                    Spacer().frame(height: 40)
                    TextFieldView(header: "Email Address", text: $viewModel.emailText, placeholderText: "Enter your email", isSecuredField: false)
                    Spacer().frame(height: 27)
                    TextFieldView(header: "Password", text: $viewModel.passwordText, placeholderText: "Enter your password", isSecuredField: true)
                    Spacer().frame(height: 22)
                    HStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4).stroke(Color.grayColor, lineWidth: 1).frame(width: 22, height: 22)
                            if(viewModel.rememberPassword) {
                                Image(systemName: "checkmark").resizable().aspectRatio(CGSize(width: 1.4, height: 1), contentMode: .fill).frame(width: 7, height: 7).foregroundColor(.dayOfMonthColor).font(.system(size: 10, weight: .medium))
                            }
                        }
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.1)) {
                                viewModel.rememberPassword.toggle()
                            }
                        }
                        Text("Remember Me")
                            .font(.custom("Poppins-Medium", size: 13))
                            .foregroundColor(.dayOfMonthColor)
                    }
                    Spacer().frame(height: 40)
                }
                Group {
                    FilledButton(text: "Login") {
                        viewModel.login { success in
                            if(!success.1.isEmpty) {
                                switch(success.0) {
                                case "teacher":
                                    generalViewModel.teacherId = success.1
                                    UserStorage.shared.saveTeacherId(teacherId: success.1)
                                    generalViewModel.scheduleType = .teacher
                                case "group":
                                    UserStorage.shared.saveGroupId(groupId: success.1)
                                    generalViewModel.groupId = success.1
                                    generalViewModel.scheduleType = .group
                                default:
                                    break
                                }
                                generalViewModel.mainScreenId += 1
                                viewModel.showProgressView = false
                                print("toMainScreenTrue")
                                viewModel.toggleValidationStatusClosure(true)
                            }
                            else {
                                print("Empty")
                            }
                        }
                    }
                    .alert(item: $viewModel.error) { error in
                        Alert(title: Text("Invalid Login"), message: Text(error.errorDescription))
                    }
                    Spacer().frame(height: 30)
                    HStack {
                        Rectangle().fill(Color.softGray).frame(height: 1)
                        Spacer().frame(width: 20)
                        Text("Or Continue as a Guest")
                            .fixedSize()
                            .foregroundColor(.dayOfMonthColor)
                            .font(.custom("Poppins-Regular", size: 13))
                        Spacer().frame(width: 20)
                        Rectangle().fill(Color.softGray).frame(height: 1)
                    }
                    Spacer().frame(height: 30)
                    HStack(spacing: 0) {
                        NavigationLink(destination: GroupPickerScreen(viewModel: generalViewModel.groupPickerScreenViewModel, editingProfileMode: false, goToNextScreen: true, isGuest: true).navigationBarBackButtonHidden(true)) {
                            UnfilledButton(text: "Student")
                        }
                        Spacer()
                        NavigationLink(destination: TeacherPickerScreen(viewModel: generalViewModel.teacherPickerScreenViewModel, editingProfileMode: false, isGuest: true, goToNextScreen: true).navigationBarBackButtonHidden(true)) {
                            UnfilledButton(text: "Teacher")
                        }
                        Spacer()
                        NavigationLink(destination: ClassroomPickerScreen(viewModel: generalViewModel.classroomPickerScreenViewModel, isGuest: true).navigationBarBackButtonHidden(true)) {
                            UnfilledButton(text: "Classroom")
                        }

                    }
                }
                Spacer()
                HStack(alignment: .center, spacing: 0) {
                    Text("Don't have an account? ")
                        .foregroundColor(.grayColor)
                    NavigationLink(destination: RegisterScreen(viewModel: generalViewModel.registerScreenViewModel).navigationBarBackButtonHidden(true)) {
                        Text("Sign Up")
                            .foregroundColor(.darkGreenColor)
                    }
                    .environmentObject(viewModel)
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
        .id(generalViewModel.rootId)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    
    static var generalViewModel = GeneralViewModel()
    
    static var previews: some View {
        LoginScreen(viewModel: generalViewModel.loginScreenViewModel)
            .environmentObject(generalViewModel)
    }
}
