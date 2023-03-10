import SwiftUI
import SwiftUICurvedRectangleShape

struct ProfileScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: ProfileScreenViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showContent: Bool = false
    var isGuest: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Color.grayColor.opacity(0.12).frame(height: geo.safeAreaInsets.top)
                    Color.grayColor.opacity(0.12).frame(height: 20) // top padding
                    ZStack (alignment: .top) {
                        ZStack(alignment: .bottom) {
                            CurvedRectangle(curveAxis: .vertical, leadingDepthPercentage: 0, trailingDepthPercentage: 12).fill(Color.grayColor.opacity(0.12))
                                .frame(height: 220)
                            ZStack(alignment: .bottomTrailing) {
                                AsyncImage(url: URL(string: UserStorage.shared.fetchAvatarLink())) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ZStack(alignment: .center) {
                                        Circle()
                                            .stroke(Color.grayColor)
                                            .frame(width: 140, height: 140)
                                        ProgressView()
                                    }
                                    .frame(width: 140, height: 140)
                                }
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                
                                EditAvatarView()
                                    .onTapGesture {
                                        viewModel.showAvatarAlert = true
                                        print(UserStorage.shared.fetchAvatarLink())
                                    }
                                    .alert("Edit your avatar link", isPresented: $viewModel.showAvatarAlert, actions: {
                                        TextField("Avatar link", text: $viewModel.avatarLink)
                                        Button("OK", action: {
                                            viewModel.setAvatar { success in
                                                if(success) {
                                                    UserStorage.shared.saveAvatarLink(avatarLink: viewModel.avatarLink)
                                                }
                                                else {
                                                    viewModel.avatarLink = UserStorage.shared.fetchAvatarLink()
                                                }
                                            }
                                        })
                                        Button("Cancel", role: .cancel, action: {
                                            viewModel.avatarLink = UserStorage.shared.fetchAvatarLink()
                                        })
                                    })
                            }
                            .opacity(isGuest ? 0 : 1)
                        }
                        ZStack(alignment: .leading) {
                            Image(systemName: "chevron.backward")
                                .padding(.leading, 10)
                                .font(.system(size: 16, weight: .medium))
                                .imageScale(.large)
                                .onTapGesture {
                                    dismiss()
                                }
                            Text(isGuest ? "Schedule" : "Profile")
                                .frame(maxWidth: .infinity)
                                .font(.custom("Poppins-Bold", size: 17))
                        }
                        .foregroundColor(.dayOfMonthColor)
                    }
                    VStack {
                        Spacer().frame(height: 5)
                        if(!viewModel.fullName.isEmpty) {
                            Text(viewModel.fullName)
                                .foregroundColor(.dayOfMonthColor)
                                .font(.custom("Poppins-Semibold", size: 22))
                        }
                        if(!viewModel.additionalInfo.isEmpty) {
                            Text(viewModel.additionalInfo)
                                .foregroundColor(.dayOfMonthColor)
                                .font(.custom("Poppins-Regular", size: 14))
                        }
                        if(!viewModel.emailText.isEmpty) {
                            Text(viewModel.emailText)
                                .foregroundColor(.dayOfMonthColor)
                                .font(.custom("Poppins-Regular", size: 14))
                        }
                        Spacer().frame(height: 32)
                        VStack(spacing: 0) {
                            if(!isGuest) {
                                ProfileSection(imageName: "newspaper", text: "Edit profile information", paddings: EdgeInsets(top: 16, leading: 16, bottom: 12, trailing: 16))
                                    .foregroundColor(.dayOfMonthColor)
                                    .onTapGesture {
                                        viewModel.showEditInfo.toggle()
                                    }
                                    .sheet(isPresented: $viewModel.showEditInfo) {
                                        NavigationStack {
                                            EditProfileScreen(viewModel: generalViewModel.editProfileScreenViewModel, selectedRole: viewModel.role == "Student" ? 0 : 1, additionalInfo: viewModel.role == "Student" ? viewModel.additionalInfo.components(separatedBy: " ")[1] : "Teacher")
                                        }
                                        .presentationDetents([.medium, .medium])
                                    }
                            }
                            NavigationLink(destination: GroupPickerScreen(viewModel: generalViewModel.groupPickerScreenViewModel, editingProfileMode: false, goToNextScreen: true, isGuest: isGuest).navigationBarBackButtonHidden(true)) {
                                ProfileSection(imageName: "person.2", text: "Groups", paddings: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                                    .foregroundColor(.dayOfMonthColor)
                            }
                            NavigationLink(destination: TeacherPickerScreen(viewModel: generalViewModel.teacherPickerScreenViewModel, editingProfileMode: false, isGuest: isGuest, goToNextScreen: true).navigationBarBackButtonHidden(true)) {
                                ProfileSection(imageName: "graduationcap", text: "Teachers", paddings: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                                    .foregroundColor(.dayOfMonthColor)
                            }
                            NavigationLink(destination: ClassroomPickerScreen(viewModel: generalViewModel.classroomPickerScreenViewModel, isGuest: isGuest).navigationBarBackButtonHidden(true)) {
                                ProfileSection(imageName: "house", text: "Classrooms", paddings: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                                    .foregroundColor(.dayOfMonthColor)
                            }
                            ProfileSection(imageName: "door.right.hand.open", text: isGuest ? "Back to login screen" : "Log out the account", paddings: EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 16))
                                .foregroundColor(.redColor)
                                .onTapGesture {
                                    if(isGuest) {
                                        print("Guest is logged out")
                                        viewModel.toggleValidationStatusClosure(false)
                                        generalViewModel.rootId = UUID()
                                        UserStorage.shared.clearAllData()
                                        generalViewModel.clearViewModels()
                                    }
                                    else {
                                        viewModel.logout { success in
                                            if(success) {
                                                goToLoginScreen()
                                            }
                                            else {
                                                viewModel.showProgressView = false
                                            }
                                        }
                                    }
                                }
                        }
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
                    }
                    .padding([.leading, .trailing], 20)
                }
                .edgesIgnoringSafeArea(.top)
            }
            if(viewModel.showProgressView) {
                Rectangle().fill(Color.white.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        }
        .onAppear {
            if(!isGuest) {
                print("Not a guest")
                viewModel.getProfile { success in
                    if(success) {
                        UserStorage.shared.saveAvatarLink(avatarLink: viewModel.avatarLink)
                    }
                    else {
                        
                        print("Una")
                    }
                }
            }
            print(viewModel.additionalInfo)
            print("appeared")
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Request"), message: Text(error.errorDescription), dismissButton: .default(Text("OK")) {
                if(viewModel.isUnauthorized) {
                    print("Una")
                    goToLoginScreen()
                }
            })
        }
//        .onChange(of: viewModel.error) { _ in
//            if(viewModel.error == AppError.profileError(.unauthorized) || viewModel.error == AppError.authenticationError(.unauthorized)) {
//                generalViewModel.clearViewModels()
//                UserStorage.shared.clearAllData()
//                viewModel.toggleValidationStatusClosure(false)
//            }
//        }
    }
    
    func goToLoginScreen() {
        viewModel.toggleValidationStatusClosure(false)
        UserStorage.shared.clearAllData()
        generalViewModel.clearViewModels()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            presentationMode.wrappedValue.dismiss()
            viewModel.showProgressView = false
        }
    }
    
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(viewModel: ProfileScreenViewModel(toggleValidationStatusClosure: { success in
            GeneralViewModel().isValidated = success
        }), isGuest: false
        )
        .environmentObject(GeneralViewModel())
    }
}
