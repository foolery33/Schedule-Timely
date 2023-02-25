//
//  EditProfileScreen.swift
//  Schedule
//
//  Created by admin on 21.02.2023.
//

import SwiftUI

struct EditProfileScreen: View {
    
    @EnvironmentObject var viewModel: GeneralViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack(alignment: .leading) {
                Image(systemName: "chevron.backward")
                    .padding(.leading, 10)
                    .font(.system(size: 16, weight: .medium))
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                Text("Edit profile")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Poppins-Bold", size: 17))
            }
            .padding([.leading, .trailing], -20)
            .foregroundColor(.dayOfMonthColor)
            Spacer().frame(height: 0)
            LabledTextFieldView(writtenText: $viewModel.editProfileScreenViewModel.emailText, labelText: "E-mail", placeholderText: "")
            HStack(spacing: 0) {
                NavigationLink(destination: GroupPickerScreen(goToNextScreen: false).navigationBarBackButtonHidden(true)) {
                    UnfilledButton(text: "Student")
                }
                Spacer()
                NavigationLink(destination: TeacherPickerScreen(goToNextScreen: false).navigationBarBackButtonHidden(true)) {
                    UnfilledButton(text: "Teacher")
                }
                .onTapGesture {
                    print("clicked")
                }
            }
            FilledButton(text: "Submit") {
                viewModel.profileScreenViewModel.emailText = viewModel.editProfileScreenViewModel.emailText
                print(viewModel.profileScreenViewModel.emailText)
            }
            Spacer()
        }
        .padding(20)
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen()
    }
}
