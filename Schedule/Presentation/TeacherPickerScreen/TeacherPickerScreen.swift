//
//  TeacherPickerScreen.swift
//  Schedule
//
//  Created by admin on 19.02.2023.
//

import SwiftUI

struct TeacherPickerScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var teacherText: String = ""
    var goToNextScreen: Bool
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
                Image(systemName: "chevron.backward")
                    .padding(.leading, 10)
                    .font(.system(size: 16, weight: .medium))
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
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
                        NavigationLink(destination: MainScreen().navigationBarBackButtonHidden(true)) {
                            if(goToNextScreen) {
                                NavigationLink(destination: MainScreen().navigationBarBackButtonHidden()) {
                                    ListRow(text: group)
                                }
                            }
                            else {
                                ListRow(text: group)
                            }
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

//struct TeacherPickerScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        TeacherPickerScreen()
//    }
//}
