//
//  LoginScreen.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var viewModel: GeneralViewModel
    
    var body: some View {
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
                TextFieldView(header: "Email Address", text: $viewModel.loginScreenViewModel.emailText, placeholderText: "Enter your email", isSecuredField: false)
                Spacer().frame(height: 27)
                TextFieldView(header: "Password", text: $viewModel.loginScreenViewModel.passwordText, placeholderText: "Enter your password", isSecuredField: true)
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
                NavigationLink(destination: MainScreen().navigationBarBackButtonHidden(true)) {
                    FilledButton(text: "Login") {}
                }
                .environmentObject(viewModel)
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
                    NavigationLink(destination: GroupPickerScreen(goToNextScreen: true).navigationBarBackButtonHidden(true)) {
                        UnfilledButton(text: "Student")
                    }
                    Spacer()
                    NavigationLink(destination: TeacherPickerScreen(goToNextScreen: true).navigationBarBackButtonHidden(true)) {
                        UnfilledButton(text: "Teacher")
                    }
                }
            }
            Spacer()
            HStack(alignment: .center, spacing: 0) {
                Text("Don't have an account? ")
                    .foregroundColor(.grayColor)
                NavigationLink(destination: RegisterScreen().navigationBarBackButtonHidden(true)) {
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
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .environmentObject(GeneralViewModel())
    }
}
