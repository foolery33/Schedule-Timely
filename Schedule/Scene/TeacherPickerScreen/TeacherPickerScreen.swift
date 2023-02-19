//
//  TeacherPickerScreen.swift
//  Schedule
//
//  Created by admin on 19.02.2023.
//

import SwiftUI

struct TeacherPickerScreen: View {
    var previousScreen: String = "s"
    @State var teacherText: String = ""
    var teachers: [String] = [
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич",
        "Усов Никита Евгеньевич"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                if(previousScreen == "main") {
                    NavigationLink(destination: MainScreen().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "chevron.backward")
                            .padding(.leading, 10)
                            .font(.system(size: 16, weight: .medium))
                            .imageScale(.large)
                    }
                }
                else {
                    NavigationLink(destination: LoginScreen(emailText: "", passwordText: "", rememberPassword: true).navigationBarBackButtonHidden(true)) {
                        Image(systemName: "chevron.backward")
                            .padding(.leading, 10)
                            .font(.system(size: 16, weight: .medium))
                            .imageScale(.large)
                    }
                }
                Text("Teachers")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Poppins-Bold", size: 17))
            }
            .foregroundColor(.dayOfMonthColor)
            Spacer().frame(height: 30)
            SearchingTextField(text: $teacherText, header: "Find a teacher by name", placeholderText: "Teacher name")
                .padding([.leading, .trailing], 20)
            
            Spacer().frame(height: 20)
            
            VStack {
                ScrollView(showsIndicators: false) {
                    Spacer().frame(height: 10)
                    ForEach(teacherText.isEmpty ? teachers : teachers.filter {$0.contains(teacherText)}, id: \.self) { group in
                        VStack(spacing: 0) {
                            HStack {
                                Text(group)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.top, .bottom], 12)
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(.dayOfMonthColor)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                
                            }
//                                .frame(height: 30)
                            .padding([.leading, .trailing], 20)
                            Rectangle().fill(Color.softGray).frame(height: 1)
                                .padding(.leading, 20)

                        }
                        
                    }
                    Spacer().frame(height: 20)
                }
            }
            .background(Color.softWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .edgesIgnoringSafeArea(.bottom)
        }
        .padding([.top, .bottom], 20)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TeacherPickerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherPickerScreen()
    }
}
