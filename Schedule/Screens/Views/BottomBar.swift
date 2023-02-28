//
//  BottomBar.swift
//  Schedule
//
//  Created by admin on 25.02.2023.
//

import SwiftUI

struct BottomBar: View {
    
    @Binding var refreshCount: Int
    @Binding var showDatePicker: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25).fill(Color.softWhite3.opacity(0.8))
                .frame(height: 70)
            HStack {
                Spacer().frame(width: 40)
                VStack(spacing: 2) {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                    Text("Date")
                        .font(.custom("Poppins-Regular", size: 11))
                }
                .onTapGesture {
                    showDatePicker = true
                }
                Spacer()
                VStack(spacing: 2) {
                    Image(systemName: "clock")
                        .imageScale(.large)
                    Text("Today")
                        .font(.custom("Poppins-Regular", size: 11))
                }
                .onTapGesture {
                    withAnimation {
                        refreshCount += 1
                    }
                }
                Spacer()
                NavigationLink(destination: ProfileScreen().navigationBarBackButtonHidden(true)) {
                    VStack(spacing: 2) {
                        Image(systemName: "person")
                            .imageScale(.large)
                        Text("Profile")
                            .font(.custom("Poppins-Regular", size: 11))
                    }
                }
                Spacer().frame(width: 40)
            }
            .foregroundColor(.darkGreenColor)
            .padding([.leading, .trailing], 5)
            .padding([.top, .bottom], 15)
        }
        .frame(height: 70)
    }
}
//
//struct BottomBar_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomBar(refreshCount: <#T##Binding<Int>#>)
//            .preferredColorScheme(.dark)
//    }
//}
