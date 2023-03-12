//
//  EditProfileScreen.swift
//  Schedule
//
//  Created by admin on 21.02.2023.
//

import SwiftUI

struct EditProfileScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: EditProfileScreenViewModel
    @Environment(\.dismiss) var dismiss
    var selectedRole: Int
    var additionalInfo: String
    
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
            VStack(alignment: .leading, spacing: 0) {
                LabledTextFieldView(writtenText: $viewModel.fullNameText, labelText: "Full Name", placeholderText: "")
                    .disabled(selectedRole == 1)
                    .onTapGesture {
                        print(selectedRole)
                    }
                Spacer().frame(height: 24)
                HStack(spacing: 0) {
                    if(selectedRole == 0) {
                        Text("Change your group:")
                        Spacer()
                        NavigationLink(destination: GroupPickerScreen(viewModel: generalViewModel.groupPickerScreenViewModel, editingProfileMode: true, goToNextScreen: false, isGuest: false).navigationBarBackButtonHidden(true)) {
                            UnfilledButton(text: viewModel.group.name?.isEmpty ?? true ? additionalInfo : viewModel.group.name ?? "")
                        }
                    }
                    else {
                        Text("Change teacher:")
                        Spacer()
                        NavigationLink(destination: TeacherPickerScreen(viewModel: generalViewModel.teacherPickerScreenViewModel, editingProfileMode: true, isGuest: false, goToNextScreen: false).navigationBarBackButtonHidden(true)) {
                            UnfilledButton(text: "Teacher")
                        }
                    }
                }
                .foregroundColor(.dayOfMonthColor)
                .font(.custom("Poppins-Medium", size: 16))
                Spacer().frame(height: 24)
                FilledButton(text: "Submit") {
//                    UserStorage.shared.saveAccessToken(accessToken:  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoidXNvdkB5YW5kZXgucnUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJUZWFjaGVyIiwibmJmIjoxNjc4MjA3OTE3LCJleHAiOjE2NzgyMjU5MTcsImlzcyI6IlRlc3RJc3N1ZXIiLCJhdWQiOiJUZXN0Q2xpZW50In0.9tchbLm39JJXzTagtfttCyVPpf1hdmfu_LGqloxh")
                    print(viewModel.group.id)
                    viewModel.changeProfile(fullName: viewModel.fullNameText) { success in
                        generalViewModel.profileScreenViewModel.showProgressView = true
                        if(success) {
                            generalViewModel.changedProfile = true
                            if(!viewModel.group.id.isEmpty) {
                                generalViewModel.registerScreenViewModel.setGroup(group: viewModel.group.id) { result in
                                    if(result) {
                                        generalViewModel.groupId = viewModel.group.id
                                        UserStorage.shared.saveGroupId(groupId: viewModel.group.id)
                                        generalViewModel.profileScreenViewModel.getProfile { _ in
                                        }
                                    }
                                    generalViewModel.profileScreenViewModel.showProgressView = false
                                }
                            }
                            else {
                                generalViewModel.profileScreenViewModel.getProfile { success in
                                    if(success) {
                                        print("succ")
                                        generalViewModel.teacherId = viewModel.teacher.id
                                        UserStorage.shared.saveTeacherId(teacherId: viewModel.teacher.id)
                                        print("updated", UserStorage.shared.fetchTeacherId())
                                    }
                                    generalViewModel.profileScreenViewModel.showProgressView = false
                                }
                            }
                        }
                        else {
                            generalViewModel.profileScreenViewModel.showProgressView = false
                        }
                    }
                }
            }
            .padding([.leading, .trailing], 20)
            Spacer()
        }
        .onAppear {
            if(viewModel.fullNameText.isEmpty) {
                viewModel.fullNameText = generalViewModel.profileScreenViewModel.fullName
            }
            if(viewModel.group.id.isEmpty) {
                viewModel.group.id = generalViewModel.profileScreenViewModel.group.id ?? ""
            }
            if(viewModel.teacher.id.isEmpty) {
                viewModel.teacher.id = generalViewModel.profileScreenViewModel.teacher.id ?? ""
            }
            print("GroupID: ", viewModel.group.id)
            print("TeacherID: ", viewModel.teacher.id)
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Request"), message: Text(error.errorDescription), dismissButton: .default(Text("OK")) {
                if(viewModel.isUnauthorized) {
                    print("Unauth")
                    presentationMode.wrappedValue.dismiss()
                    generalViewModel.profileScreenViewModel.getProfile { _ in
                    }
                }
                else {
                    print("NO")
                }
            })
        }
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen(viewModel: EditProfileScreenViewModel(toggleValidationStatusClosure: { success in
            GeneralViewModel().isValidated = success
        }), selectedRole: 0, additionalInfo: "Group: 972101")
            .environmentObject(GeneralViewModel())
    }
}
