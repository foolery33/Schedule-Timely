//
//  LoginScreen.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct LoginScreen: View {
    @State var emailText: String
    @State var passwordText: String
    @State var rememberPassword: Bool
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
                TextFieldView(header: "Email Address", text: emailText, placeholderText: "Enter your email", isSecuredField: false)
                Spacer().frame(height: 27)
                TextFieldView(header: "Password", text: passwordText, placeholderText: "Enter your password", isSecuredField: true)
                Spacer().frame(height: 22)
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4).stroke(Color.grayColor, lineWidth: 1).frame(width: 22, height: 22)
                        if(rememberPassword) {
                            Image(systemName: "checkmark").resizable().aspectRatio(CGSize(width: 1.4, height: 1), contentMode: .fill).frame(width: 7, height: 7).foregroundColor(.dayOfMonthColor).font(.system(size: 10, weight: .medium))
                        }
                    }
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            rememberPassword.toggle()
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
                    FilledButton(text: "Login")
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
                NavigationLink(destination: RegisterScreen(emailText: "", passwordText: "", confirmPassword: "", rememberPassword: true).navigationBarBackButtonHidden(true)) {
                    Text("Sign Up")
                        .foregroundColor(.darkGreenColor)
                }
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
        LoginScreen(emailText: "", passwordText: "", rememberPassword: true)
    }
}
