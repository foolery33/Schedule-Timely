//
//  EditProfileScreen.swift
//  Schedule
//
//  Created by admin on 21.02.2023.
//

import SwiftUI

struct EditProfileScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: EditProfileScreenViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 20)
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
            .foregroundColor(.dayOfMonthColor)
            Spacer().frame(height: 50)
            VStack(alignment: .leading, spacing: 24) {
                LabledTextFieldView(writtenText: $viewModel.emailText, labelText: "E-mail", placeholderText: "")
                HStack(spacing: 0) {
                    NavigationLink(destination: GroupPickerScreen(viewModel: generalViewModel.groupPickerScreenViewModel, goToNextScreen: false).navigationBarBackButtonHidden(true)) {
                        UnfilledButton(text: "Student")
                    }
                    Spacer()
                    NavigationLink(destination: TeacherPickerScreen(viewModel: generalViewModel.teacherPickerScreenViewModel, goToNextScreen: false).navigationBarBackButtonHidden(true)) {
                        UnfilledButton(text: "Teacher")
                    }
                }
                FilledButton(text: "Submit") {
                    dismiss()
                }
            }
            .padding([.leading, .trailing], 20)
            Spacer()
        }
    }
}

//struct EditProfileScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileScreen()
//            .environmentObject(GeneralViewModel())
//    }
//}
