//
//  MainScreen.swift
//  Schedule
//
//  Created by admin on 14.02.2023.
//

import SwiftUI

struct MainScreen: View {
    
    let daysOfWeek = getDaysOfWeek()
    @State var isDescendingOrder: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Color.softWhite.frame(height: geo.safeAreaInsets.top)
                HStack {
                    Text("24")
                        .font(.custom("Poppins-Medium", size: 40))
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Wed")
                        Text("Jan 2020")
                    }
                    .foregroundColor(.softGray)
                    .font(.custom("Poppins-Medium", size: 13))
                    Spacer()
                    Text("Today")
                        .foregroundColor(.todayTextColor)
                        .padding([.leading, .trailing], 18)
                        .padding([.top, .bottom], 11)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.todayTextBackgroundColor))
                        .font(.custom("Poppins-Semibold", size: 15))
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 30).fill(.white)
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(daysOfWeek, id: \.self) { day in
                                DateView(
                                    dayOfWeek: getDayOfWeekByDate(date: day),
                                    dayOfMonth: getDayOfMonthByDate(date: day),
                                    isPressed: isCurrentDay(comparedDay: getDayOfMonthByDate(date: day))
                                )
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
                                .rotationEffect(Angle.degrees(isDescendingOrder ? 0 : 180))
                                .onTapGesture {
                                    withAnimation {
                                        isDescendingOrder.toggle()
                                    }
                                }
                        }
                        .padding([.leading, .trailing], 20)
                        .foregroundColor(.softGray)
                        Spacer().frame(height: 15)
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 16) {
                                SubjectView(isFirstSubjectOfTheDay: true, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                            }
                        }
                        .padding([.leading, .trailing], 20)
                    }
                }
                Spacer()
            }
            .background(Color.softWhite)
            .edgesIgnoringSafeArea([.top])
        }
        
    }
    
    static func getDaysOfWeek() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        return (0...6).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    func getDayOfMonthByDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    func getDayOfWeekByDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let string = dateFormatter.string(from: date)
        return String(string.character(at: 0)!).uppercased()
    }
    
    func isCurrentDay(comparedDay: String) -> Bool {
        let date = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let dayOfMonth = dateFormatter.string(from: date ?? Date())
        return dayOfMonth == comparedDay
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
    }
}
