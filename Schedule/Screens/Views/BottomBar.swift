//
//  BottomBar.swift
//  Schedule
//
//  Created by admin on 25.02.2023.
//

import SwiftUI

struct BottomBar: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @Binding var refreshCount: Int
    @Binding var showDatePicker: Bool
    var isGuest: Bool
    var notTheFirstScreen: Bool
    
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
                if(notTheFirstScreen) {
                    VStack(spacing: 2) {
                        Image(systemName: "house")
                            .imageScale(.large)
                        Text("Home")
                            .font(.custom("Poppins-Regular", size: 11))
                    }
                    .onTapGesture {
                        generalViewModel.mainScreenViewModel.daysOfWeek = generalViewModel.mainScreenViewModel.getDaysOfWeek(for: Date())
                        generalViewModel.mainScreenViewModel.currentDayIndex = generalViewModel.mainScreenViewModel.weekdayIndex(for: Date())
                        generalViewModel.mainScreenId = 0
                    }
                }
                else {
                    NavigationLink(destination: ProfileScreen(viewModel: generalViewModel.profileScreenViewModel, isGuest: isGuest).navigationBarBackButtonHidden(true)) {
                        VStack(spacing: 2) {
                            Image(systemName: isGuest ? "list.bullet" : "person")
                                .imageScale(.large)
                            Text(isGuest ? "Schedule" : "Profile")
                                .font(.custom("Poppins-Regular", size: 11))
                        }
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
