//
//  ContentView.swift
//  Schedule
//
//  Created by admin on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            LoginScreen(emailText: "", passwordText: "", rememberPassword: true)
//            ProfileScreen(name: "Nikita Usov", email: "usov107@gmail.com", role: "Student", showAvatarAlert: false, avatarLink: "https://sun9-60.userapi.com/impg/lp3muZxbvoxi6PZOOf7WjxUbfd9W5r7aS3_eFA/TYGK-wiRI3E.jpg?size=1704x1704&quality=96&sign=0da84aed28474606b6877141d50221b1&type=album")
//            EditProfileScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
