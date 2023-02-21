//
//  MainScreen.swift
//  Schedule
//
//  Created by admin on 14.02.2023.
//

import SwiftUI

struct MainScreen: View {

    private let daysOfWeek = getDaysOfWeek()
    @State private var isDescendingOrder: Bool = true
    @State private var currentDayIndex = weekdayIndex(for: Date())

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Color.softWhite.frame(height: geo.safeAreaInsets.top)
                HStack {
                    Text(getDayOfMonthByDate(date: daysOfWeek[currentDayIndex]))
                        .font(.custom("Poppins-Medium", size: 40))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(getDayOfWeekByDate(date: daysOfWeek[currentDayIndex], lettersCount: 3))
                        Text("\(abbreviatedMonthName(date: daysOfWeek[currentDayIndex], count: 3)) \(String(getYearFromDate(daysOfWeek[currentDayIndex])))")
                    }
                    .foregroundColor(.softGray)
                    .font(.custom("Poppins-Medium", size: 13))
                    Spacer()
                    if(MainScreen.currentWeekdayIndex() == currentDayIndex) {
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
                ZStack {
                    RoundedRectangle(cornerRadius: 30).fill(.white)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(daysOfWeek, id: \.self) { day in
                                DateView(
                                    dayOfWeek: getDayOfWeekByDate(date: day, lettersCount: 1),
                                    dayOfMonth: getDayOfMonthByDate(date: day),
                                    isPressed: (MainScreen.weekdayIndex(for: day) == currentDayIndex)
                                )
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.2)) {
                                        currentDayIndex = MainScreen.weekdayIndex(for: day)
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
                        TabView(selection: $currentDayIndex) {
                            ForEach(0...6, id: \.self) { day in
                                ScheduleDayView()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
            }
            .animation(.linear(duration: 0.2), value: currentDayIndex)
            .background(Color.softWhite)
            .edgesIgnoringSafeArea([.top, .bottom])
        }


    }

    static func weekdayIndex(for date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        let weekday = (components.weekday! + 5) % 7
        return weekday
    }

    static func currentWeekdayIndex() -> Int {
        let weekdayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        return (weekdayIndex - 1 + 7) % 7
    }

    static func getDaysOfWeek() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let dayOfWeek = calendar.component(.weekday, from: today)
        let daysInWeek = 7
        let firstWeekday = 2 // 1 is Sunday, 2 is Monday
        let offset = firstWeekday - dayOfWeek
        var dateComponents = DateComponents()
        dateComponents.day = offset
        guard let monday = calendar.date(byAdding: dateComponents, to: today) else {
            return []
        }
        var dates: [Date] = []
        for i in 0..<daysInWeek {
            let date = calendar.date(byAdding: .day, value: i, to: monday)!
            dates.append(date)
        }
        return dates
    }

    func abbreviatedMonthName(date: Date, count: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let month = dateFormatter.string(from: date)
        return String(month.prefix(count)).capitalized
    }

    func getYearFromDate(_ date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }

    func getDayOfMonthByDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    func getDayOfWeekByDate(date: Date, lettersCount: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)

        let index = weekday.index(weekday.startIndex, offsetBy: lettersCount)
        return String(weekday[..<index]).capitalized
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

