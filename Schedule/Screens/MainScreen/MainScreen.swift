//
//  MainScreen.swift
//  Schedule
//
//  Created by admin on 14.02.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var viewModel: GeneralViewModel
    @State private var refreshCount: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    Color.softWhite.frame(height: geo.safeAreaInsets.top)
                    HStack {
                        Text(viewModel.mainScreenViewModel.getDayOfMonthByDate(date: viewModel.mainScreenViewModel.daysOfWeek[viewModel.currentDayIndex]))
                            .font(.custom("Poppins-Medium", size: 40))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    viewModel.isValidated = false
                                }
                            }
                        VStack(alignment: .leading, spacing: 2) {
                            Text(viewModel.mainScreenViewModel.getDayOfWeekByDate(date: viewModel.mainScreenViewModel.daysOfWeek[viewModel.currentDayIndex], lettersCount: 3))
                            Text(
                                "\(viewModel.mainScreenViewModel.abbreviatedMonthName(date: viewModel.mainScreenViewModel.daysOfWeek[viewModel.currentDayIndex], count: 3)) \(String(viewModel.mainScreenViewModel.getYearFromDate(viewModel.mainScreenViewModel.daysOfWeek[viewModel.currentDayIndex])))"
                            )
                        }
                        .padding(.bottom, 1)
                        .foregroundColor(.softGray)
                        .font(.custom("Poppins-Medium", size: 13))
                        Spacer()
                        if(viewModel.mainScreenViewModel.weekdayIndex(for: Date()) == viewModel.currentDayIndex) {
                            Text("Today")
                                .foregroundColor(.todayTextColor)
                                .padding([.leading, .trailing], 18)
                                .padding([.top, .bottom], 11)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.todayTextBackgroundColor))
                                .font(.custom("Poppins-Semibold", size: 15))
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 30).fill(.white)
                            .edgesIgnoringSafeArea(.bottom)
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                ForEach(viewModel.mainScreenViewModel.daysOfWeek, id: \.self) { day in
                                    DateView(
                                        dayOfWeek: viewModel.mainScreenViewModel.getDayOfWeekByDate(date: day, lettersCount: 1),
                                        dayOfMonth: viewModel.mainScreenViewModel.getDayOfMonthByDate(date: day),
                                        isPressed: (viewModel.mainScreenViewModel.weekdayIndex(for: day) == viewModel.currentDayIndex)
                                    )
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.2)) {
                                            viewModel.currentDayIndex = viewModel.mainScreenViewModel.weekdayIndex(for: day)
                                        }
                                    }
                                }
                            }
                            .padding([.leading, .trailing], 5)
                            .padding([.top, .bottom] , 10)
                            Divider().frame(height: 2).overlay(Color.softWhite)
                            Spacer().frame(height: 10)
                            HStack(spacing: 0) {
                                Text("Time")
                                    .frame(width: 50, alignment: .leading)
                                    .font(.custom("Poppins-Medium", size: 14))
                                Text("Course")
                                    .font(.custom("Poppins-Medium", size: 14))
                                Spacer()
                                Image(systemName: "arrow.turn.right.down")
                                    .imageScale(.medium)
                                    .rotationEffect(Angle.degrees(viewModel.isAscendingOrder ? 0 : 180))
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.isAscendingOrder.toggle()
                                        }
                                    }
                            }
                            .padding([.leading, .trailing], 20)
                            .foregroundColor(.softGray)
                            Spacer().frame(height: 15)
                            TabView(selection: $viewModel.currentDayIndex) {
                                ForEach(0...6, id: \.self) { day in
                                    ScheduleDayView()
                                        .edgesIgnoringSafeArea(.bottom)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        }
                        BottomBar(refreshCount: $refreshCount)
                            .padding(20)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
                .animation(.linear(duration: 0.2), value: viewModel.currentDayIndex)
                .background(Color.softWhite)
                .edgesIgnoringSafeArea([.top, .bottom])
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .id(refreshCount)
        .onChange(of: refreshCount) { _ in
            viewModel.currentDayIndex = viewModel.mainScreenViewModel.weekdayIndex(for: Date())
        }
    }
}

extension String {
    
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .environmentObject(GeneralViewModel())
    }
}

