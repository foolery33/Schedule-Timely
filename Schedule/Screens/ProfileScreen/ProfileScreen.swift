import SwiftUI
import SwiftUICurvedRectangleShape

struct ProfileScreen: View {

    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: ProfileScreenViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showContent: Bool = false

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
                                            }
                                        })
                                        Button("Cancel", role: .cancel, action: {
                                            viewModel.avatarLink = UserStorage.shared.fetchAvatarLink()
                                        })
                                    })
                            }
                        }
                        ZStack(alignment: .leading) {
                            Image(systemName: "chevron.backward")
                                .padding(.leading, 10)
                                .font(.system(size: 16, weight: .medium))
                                .imageScale(.large)
                                .onTapGesture {
                                    dismiss()
                                }
                            Text("Profile")
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
                            ProfileSection(imageName: "newspaper", text: "Edit profile information", paddings: EdgeInsets(top: 16, leading: 16, bottom: 12, trailing: 16))
                                .foregroundColor(.dayOfMonthColor)
                                .onTapGesture {
                                    viewModel.showEditInfo.toggle()
                                }
                                .sheet(isPresented: $viewModel.showEditInfo) {
                                    NavigationStack {
                                        EditProfileScreen(viewModel: generalViewModel.editProfileScreenViewModel)
                                    }
                                    .presentationDetents([.medium, .medium])
                                }
                            ProfileSection(imageName: "person.2", text: "Groups", paddings: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                                .foregroundColor(.dayOfMonthColor)
                            ProfileSection(imageName: "graduationcap", text: "Teachers", paddings: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                                .foregroundColor(.dayOfMonthColor)
                            ProfileSection(imageName: "door.right.hand.open", text: "Log out the account", paddings: EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 16))
                                .foregroundColor(.redColor)
                                .onTapGesture {
                                    viewModel.logout { success in
                                        if(success) {
                                            viewModel.toggleValidationStatusClosure(!success)
                                            print("succ")
                                            UserStorage.shared.clearAllData()
                                            generalViewModel.loginScreenViewModel = LoginScreenViewModel(toggleValidationStatusClosure: { isValidated in
                                                generalViewModel.isValidated = isValidated
                                            })
                                            generalViewModel.registerScreenViewModel = RegisterScreenViewModel(toggleValidationStatusClosure: { isValidated in
                                                generalViewModel.isValidated = isValidated
                                            })
                                            generalViewModel.clearViewModels()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    print("stopped")
                                                    viewModel.showProgressView = false
                                                }
                                                print("dismissed")
                                                presentationMode.wrappedValue.dismiss()
                                            }
                                        }
                                        else {
                                            viewModel.showProgressView = false
                                        }
                                    }
                                }
                                .alert(item: $viewModel.error) { error in
                                    Alert(title: Text("Invalid Request"), message: Text(error.errorDescription))
                                }
                        }
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
                        .padding([.leading, .trailing], 20)
                    }
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
            print("appeared")
            viewModel.getProfile { success in
                UserStorage.shared.saveAvatarLink(avatarLink: viewModel.avatarLink)
                print("Avatar1: ", viewModel.avatarLink)
                print("Avatar2: ", UserStorage.shared.fetchAvatarLink())
            }
        }
        
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(viewModel: ProfileScreenViewModel(toggleValidationStatusClosure: { success in
            GeneralViewModel().isValidated = success
        })
                      )
            .environmentObject(GeneralViewModel())
    }
}
