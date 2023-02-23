import SwiftUI
import SwiftUICurvedRectangleShape

struct ProfileScreen: View {


    var name: String
    var email: String
    var role: String
    @State var showAvatarAlert: Bool
    @State var avatarLink: String
    @State var showEditInfo: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Color.grayColor.opacity(0.12).frame(height: geo.safeAreaInsets.top)
                Color.grayColor.opacity(0.12).frame(height: 20) // top padding
                ZStack (alignment: .top) {
                    ZStack(alignment: .bottom) {
                        CurvedRectangle(curveAxis: .vertical, leadingDepthPercentage: 0, trailingDepthPercentage: 12).fill(Color.grayColor.opacity(0.12))
                            .frame(height: 220)
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: URL(string: avatarLink)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 140, height: 140)
                                    .aspectRatio(contentMode: .fill)
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
                                    showAvatarAlert = true
                                }
                                .alert("Edit your avatar link", isPresented: $showAvatarAlert, actions: {
                                    TextField("Avatar link", text: $avatarLink)
                                    Button("OK", action: {})
                                    Button("Cancel", role: .cancel, action: {})
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
                    Text(name)
                        .foregroundColor(.dayOfMonthColor)
                        .font(.custom("Poppins-Semibold", size: 22))
                    Spacer().frame(height: 1)
                    Text(email)
                        .foregroundColor(.dayOfMonthColor)
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer().frame(height: 32)
                    VStack(spacing: 0) {
                        ProfileSection(imageName: "newspaper", text: "Edit profile information", paddings: EdgeInsets(top: 16, leading: 16, bottom: 12, trailing: 16))
                            .foregroundColor(.dayOfMonthColor)
                            .onTapGesture {
                                showEditInfo.toggle()
                            }
                            .sheet(isPresented: $showEditInfo) {
                                NavigationStack {
                                    EditProfileScreen()
                                }
                                .presentationDetents([.large, .medium])
                            }
                        ProfileSection(imageName: "person.2", text: "Groups", paddings: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                            .foregroundColor(.dayOfMonthColor)
                        ProfileSection(imageName: "graduationcap", text: "Teachers", paddings: EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                            .foregroundColor(.dayOfMonthColor)
                        ProfileSection(imageName: "door.right.hand.open", text: "Log out the account", paddings: EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 16))
                            .foregroundColor(.redColor)
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 2))
                    .padding([.leading, .trailing], 20)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(name: "Nikita Usov", email: "usov107@gmail.com", role: "Student", showAvatarAlert: false, avatarLink: "https://sun9-60.userapi.com/impg/lp3muZxbvoxi6PZOOf7WjxUbfd9W5r7aS3_eFA/TYGK-wiRI3E.jpg?size=1704x1704&quality=96&sign=0da84aed28474606b6877141d50221b1&type=album")
    }
}
