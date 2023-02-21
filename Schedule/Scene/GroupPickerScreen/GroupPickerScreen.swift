//
//  GroupPickerScreen.swift
//  Schedule
//
//  Created by admin on 19.02.2023.
//

import SwiftUI

struct GroupPickerScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var groupText: String = ""
    var groups: [String] = [
        "972101",
        "132105",
        "972003",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101",
        "972101"
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
                Text("Groups")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Poppins-Bold", size: 17))
            }
            .foregroundColor(.dayOfMonthColor)
            Spacer().frame(height: 30)
            SearchingTextField(text: $groupText, header: "Find your group", placeholderText: "Group number")
                .padding([.leading, .trailing], 20)
            
            Spacer().frame(height: 20)
            
            VStack {
                ScrollView(showsIndicators: false) {
                    Spacer().frame(height: 10)
                    ForEach(groupText.isEmpty ? groups : groups.filter {$0.contains(groupText)}, id: \.self) { group in
                        NavigationLink(destination: MainScreen().navigationBarBackButtonHidden()) {
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

//struct GroupPickerScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupPickerScreen()
//    }
//}
