//
//  MainScreen.swift
//  Schedule
//
//  Created by admin on 14.02.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @Environment(\.dismiss) var dismiss
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
                        if(generalViewModel.mainScreenId > 0) {
                            // Просмотр не своего основного расписания
                            Spacer().frame(height: 20)
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .padding(.leading, 10)
                                    .font(.system(size: 16, weight: .medium))
                                    .imageScale(.large)
                                    .onTapGesture {
                                        viewModel.daysOfWeek = viewModel.getDaysOfWeek(for: Date())
                                        viewModel.currentDayIndex = viewModel.weekdayIndex(for: Date())
                                        generalViewModel.mainScreenId -= 1
                                    }
                                Spacer()
                            }
                            
                        }
                        HStack {
                            Text(
                                viewModel.getDayOfMonthByDate(date: viewModel.daysOfWeek[viewModel.currentDayIndex])
                            )
                            .font(.custom("Poppins-Medium", size: 40))
                            .onTapGesture {
                                print(generalViewModel.mainScreenId)
                            }
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
                                .opacity(viewModel.showContent ? 1 : 0)
                            }
                            BottomBar(refreshCount: $refreshCount, showDatePicker: $showDatePicker, isGuest: UserStorage.shared.fetchAccessToken().isEmpty, notTheFirstScreen: generalViewModel.mainScreenId != 0)
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
                        viewModel.daysOfWeek = viewModel.getDaysOfWeek(for: currentDate)
                        viewModel.currentDayIndex = viewModel.weekdayIndex(for: currentDate)
                        currentDate = Date()
                        loadSchedule()
                    }
                    .presentationDetents([.height(350)])
                }
            }
            if(viewModel.showProgressView) {
                ProgressView()
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Shedule Loading"), message: Text(error.errorDescription))
        }
        .onAppear {
            viewModel.showProgressView = true
            viewModel.showContent = false
            DispatchQueue.main.async {
                if let requestInfo = generalViewModel.path[generalViewModel.mainScreenId] {
                    generalViewModel.path[generalViewModel.mainScreenId + 1] = nil
                    generalViewModel.scheduleType = requestInfo.0
                    switch requestInfo.0 {
                    case .group:
                        if(generalViewModel.changedProfile && generalViewModel.mainScreenId == 0) {
                            generalViewModel.path[generalViewModel.mainScreenId] = (.group, generalViewModel.groupId)
                            generalViewModel.changedProfile = false
                        }
                        else {
                            generalViewModel.groupId = requestInfo.1
                        }
                    case .teacher:
                        if(generalViewModel.changedProfile && generalViewModel.mainScreenId == 0) {
                            generalViewModel.path[generalViewModel.mainScreenId] = (.teacher, generalViewModel.teacherId)
                            generalViewModel.changedProfile = false
                        }
                        else {
                            generalViewModel.teacherId = requestInfo.1
                        }
                    case .classroom:
                        generalViewModel.classroomId = requestInfo.1
                    }
                }
                loadSchedule()
            }
            print(viewModel.sortedWeekLessons)
        }
        .onChange(of: refreshCount) { _ in
            viewModel.showContent = false
            viewModel.daysOfWeek = viewModel.getDaysOfWeek(for: Date())
            viewModel.currentDayIndex = viewModel.weekdayIndex(for: Date())
            loadSchedule()
        }
        .onChange(of: viewModel.sortedWeekLessons) { _ in
            print(viewModel.sortedWeekLessons)
        }
        .id(generalViewModel.mainScreenId)
    }
    
    func prepareData(forward: Bool) {
        viewModel.daysOfWeek = viewModel.getDaysOfWeek(
            for: viewModel.getDateWithOffset(
                from: viewModel.daysOfWeek[forward ? 6 : 0], byDays: (forward ? 1 : -1)
            )
        )
        viewModel.showContent = false
        viewModel.currentDayIndex = 0
    }
    
    func loadSchedule() {
        switch generalViewModel.scheduleType {
        case .group:
            print("Group: ", generalViewModel.groupId)
            print("FetchGroup: ", UserStorage.shared.fetchGroupId())
            var group = generalViewModel.groupId
            group = group.isEmpty ? UserStorage.shared.fetchGroupId() : group
            print("FinalDecision: ", group)
            if(!group.isEmpty) {
                viewModel.getGroupSchedule(date: ConvertDateIntoString().convert(viewModel.daysOfWeek[viewModel.currentDayIndex]), groupId: group) { success in
                    if(success) {
                        generalViewModel.path[generalViewModel.mainScreenId] = (ScheduleType.group, group)
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationLength + 0.1) {
                            viewModel.showProgressView = false
                            viewModel.showContent = true
                        }
                    }
                }
            }
        case .teacher:
            print("Teacher: ", generalViewModel.teacherId)
            print("FetchTeacher: ", UserStorage.shared.fetchTeacherId())
            var teacher = generalViewModel.teacherId
            teacher = teacher.isEmpty ? UserStorage.shared.fetchTeacherId() : teacher
            if(!teacher.isEmpty) {
                viewModel.getTeacherSchedule(date: ConvertDateIntoString().convert(viewModel.daysOfWeek[viewModel.currentDayIndex]), teacherId: teacher) { success in
                    if(success) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationLength + 0.1) {
                            generalViewModel.path[generalViewModel.mainScreenId] = (ScheduleType.teacher, teacher)
                            viewModel.showProgressView = false
                            viewModel.showContent = true
                        }
                    }
                }
            }
        case .classroom:
            print("Classroom: ", generalViewModel.classroomId)
            print("FetchClassroom: ", UserStorage.shared.fetchClassroomId())
            var classroom = generalViewModel.classroomId
            classroom = classroom.isEmpty ? UserStorage.shared.fetchClassroomId() : classroom
            if(!classroom.isEmpty) {
                viewModel.getClassroomSchedule(date: ConvertDateIntoString().convert(viewModel.daysOfWeek[viewModel.currentDayIndex]), classroomId: classroom) { success in
                    if(success) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationLength + 0.1) {
                            generalViewModel.path[generalViewModel.mainScreenId] = (ScheduleType.classroom, classroom)
                            viewModel.showProgressView = false
                            viewModel.showContent = true
                        }
                    }
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

