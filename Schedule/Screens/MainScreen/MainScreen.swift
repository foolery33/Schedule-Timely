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
    private let animationLength: Double = 0.2
    
    var body: some View {
        ZStack {
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
                        .animation(.linear(duration: animationLength), value: viewModel.currentDayIndex)
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 30).fill(.white)
                                .edgesIgnoringSafeArea(.bottom)
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Image(systemName: "chevron.backward")
                                        .onTapGesture {
                                            prepareData(forward: false)
                                            loadSchedule()
                                        }
                                    Spacer()
                                    ForEach(viewModel.daysOfWeek, id: \.self) { day in
                                        DateView(
                                            dayOfWeek: viewModel.getDayOfWeekByDate(date: day, lettersCount: 1),
                                            dayOfMonth: viewModel.getDayOfMonthByDate(date: day),
                                            isPressed: (viewModel.currentDayIndex == viewModel.weekdayIndex(for: day))
                                        )
                                        .animation(.linear(duration: animationLength), value: viewModel.currentDayIndex)
                                        .onTapGesture {
                                            viewModel.currentDayIndex = viewModel.weekdayIndex(for: day)
                                        }
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .onTapGesture {
                                            prepareData(forward: true)
                                            loadSchedule()
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
                                    Image(systemName: "arrow.turn.right.up")
                                        .imageScale(.medium)
                                        .rotationEffect(Angle.degrees(viewModel.isAscendingOrder ? 0 : -180))
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
                                        ScheduleDayView(
                                            lessons: viewModel.isAscendingOrder ?
                                            viewModel.sortedWeekLessons[day] :
                                            viewModel.sortedWeekLessons[day].reversed()
                                        )
                                        .edgesIgnoringSafeArea(.bottom)
                                    }
                                }
                                .animation(.linear(duration: animationLength), value: viewModel.currentDayIndex)
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
                        loadSchedule()
                    }
                    .presentationDetents([.height(350)])
                }
            }
            if(viewModel.showProgressView) {
                Rectangle().fill(Color.white.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        }
        .onChange(of: refreshCount) { _ in
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.daysOfWeek = viewModel.getDaysOfWeek(for: Date())
                viewModel.currentDayIndex = viewModel.weekdayIndex(for: Date())
                loadSchedule()
            }
        }
        .onAppear {
            loadSchedule()
        }
    }
    
    func prepareData(forward: Bool) {
        viewModel.daysOfWeek = viewModel.getDaysOfWeek(
            for: viewModel.getDateWithOffset(
                from: viewModel.daysOfWeek[forward ? 6 : 0], byDays: (forward ? 1 : -1)
            )
        )
        viewModel.currentDayIndex = 0
        viewModel.sortedWeekLessons = [[], [], [], [], [], [], []]
    }
    
    func loadSchedule() {
        if(!UserStorage.shared.fetchGroupId().isEmpty) {
            viewModel.getGroupSchedule(date: ConvertDateIntoString().convert(viewModel.daysOfWeek[viewModel.currentDayIndex])) { success in
                viewModel.showProgressView = false
                if(success) {
                    viewModel.sortedWeekLessons = GetWeekSchedule().getWeekSchedule(from: viewModel.weekLessons, dates: viewModel.daysOfWeek)
                    print(viewModel.sortedWeekLessons)
                    print(viewModel.sortedWeekLessons.count)
                }
            }
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

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            MainScreen(viewModel: MainScreenViewModel())
//        }
//        .environmentObject(GeneralViewModel())
//    }
//}

