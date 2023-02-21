//
//  RegisterScreen.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct RegisterScreen: View {
    @State var emailText: String
    @State var passwordText: String
    @State var confirmPassword: String
    @State var rememberPassword: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Create Account")
                .font(.custom("Poppins-semibold", size: 21))
                .foregroundColor(.dayOfMonthColor)
            Spacer().frame(height: 8)
            Text("Check out your schedule everyday!")
                .font(.custom("Poppins-regular", size: 14))
                .foregroundColor(.grayColor)
            Group {
                Spacer().frame(height: 40)
                TextFieldView(header: "Email Address", text: emailText, placeholderText: "Enter your email", isSecuredField: false)
                Spacer().frame(height: 27)
                TextFieldView(header: "Password", text: passwordText, placeholderText: "Enter your password", isSecuredField: true)
                Spacer().frame(height: 27)
                TextFieldView(header: "Confirm Password", text: passwordText, placeholderText: "Confirm your password", isSecuredField: true)
                Spacer().frame(height: 27)
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
                        NavigationLink(destination: GroupPickerScreen().navigationBarBackButtonHidden(true)) {
                            UnfilledButton(text: "Student")
                        }
                        Spacer()
                        NavigationLink(destination: TeacherPickerScreen().navigationBarBackButtonHidden(true)) {
                            UnfilledButton(text: "Teacher")
                        }
                    }
                }
                Spacer().frame(height: 40)
            }
            Group {
                FilledButton(text: "Sign up")
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
    }

}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen(emailText: "", passwordText: "", confirmPassword: "", rememberPassword: true)
    }
}
