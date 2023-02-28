//
//  MainScreen.swift
//  Schedule
//
//  Created by admin on 14.02.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: MainScreenViewModel
    @State private var refreshCount: Int = 0
    @State private var showDatePicker: Bool = false
    @State private var currentDate: Date = Date()
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    Color.softWhite.frame(height: geo.safeAreaInsets.top)
                    HStack {
                        Text(
                            viewModel.getDayOfMonthByDate(date: viewModel.daysOfWeek[viewModel.currentDayIndex])
                            )
                            .font(.custom("Poppins-Medium", size: 40))
                        VStack(alignment: .leading, spacing: 2) {
                            Text(viewModel.getDayOfWeekByDate(date: viewModel.daysOfWeek[viewModel.currentDayIndex], lettersCount: 3))
                            Text(
                                "\(viewModel.abbreviatedMonthName(date: viewModel.daysOfWeek[viewModel.currentDayIndex], count: 3)) \(String(viewModel.getYearFromDate(viewModel.daysOfWeek[viewModel.currentDayIndex])))"
                            )
                        }
                        .padding(.bottom, 1)
                        .foregroundColor(.softGray)
                        .font(.custom("Poppins-Medium", size: 13))
                        Spacer()
                        if(viewModel.isToday(viewModel.daysOfWeek[viewModel.currentDayIndex])) {
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
                                Image(systemName: "chevron.backward")
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.daysOfWeek = viewModel.getDaysOfWeek(
                                                for: viewModel.getDateWithOffset(
                                                    from: viewModel.daysOfWeek[0], byDays: -1
                                                )
                                            )
                                            viewModel.currentDayIndex = 0
                                        }
                                    }
                                Spacer()
                                ForEach(viewModel.daysOfWeek, id: \.self) { day in
                                    DateView(
                                        dayOfWeek: viewModel.getDayOfWeekByDate(date: day, lettersCount: 1),
                                        dayOfMonth: viewModel.getDayOfMonthByDate(date: day),
                                        isPressed: (viewModel.currentDayIndex == viewModel.weekdayIndex(for: day))
                                    )
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.2)) {
                                            viewModel.currentDayIndex = viewModel.weekdayIndex(for: day)
                                        }
                                    }
                                }
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.daysOfWeek = viewModel.getDaysOfWeek(
                                                for: viewModel.getDateWithOffset(
                                                    from: viewModel.daysOfWeek[6], byDays: 1
                                                )
                                            )
                                            viewModel.currentDayIndex = 0
                                        }
                                    }
                            }
                            .padding([.leading, .trailing], 10)
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
                                    .onChange(of: viewModel.isAscendingOrder) { _ in
                                        print(viewModel.isAscendingOrder)
                                    }
                            }
                            .padding([.leading, .trailing], 20)
                            .foregroundColor(.softGray)
                            Spacer().frame(height: 15)
                            TabView(selection: $viewModel.currentDayIndex) {
                                ForEach(0...6, id: \.self) { day in
                                    ScheduleDayView()
                                        .onTapGesture {
                                            print("Day is: \(day), and currentDayIndex is: \(viewModel.currentDayIndex)")
                                        }
                                        .edgesIgnoringSafeArea(.bottom)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        }
                        BottomBar(refreshCount: $refreshCount, showDatePicker: $showDatePicker)
                            .environmentObject(viewModel)
                            .padding(20)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
                .background(Color.softWhite)
                .edgesIgnoringSafeArea([.top, .bottom])
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showDatePicker) {
                DatePickerView(selectedDate: $currentDate) {
                    print("action preformed")
                    print(currentDate)
                    viewModel.daysOfWeek = viewModel.getDaysOfWeek(for: currentDate)
                    viewModel.currentDayIndex = viewModel.weekdayIndex(for: currentDate)
                    currentDate = Date()
                }
                .presentationDetents([.height(350)])
            }
        }
        .id(refreshCount)
        .onChange(of: refreshCount) { _ in
            viewModel.daysOfWeek = viewModel.getDaysOfWeek(for: Date())
            viewModel.currentDayIndex = viewModel.weekdayIndex(for: Date())
        }
        .onChange(of: viewModel.daysOfWeek) { _ in
            print(viewModel.daysOfWeek)
        }
        .onAppear {
            print(viewModel.daysOfWeek)
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
        NavigationStack {
            MainScreen(viewModel: MainScreenViewModel())
        }
        .environmentObject(GeneralViewModel())
    }
}

