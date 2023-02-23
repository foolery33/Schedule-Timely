//
//  ScheduleDayView.swift
//  Schedule
//
//  Created by admin on 21.02.2023.
//

import SwiftUI

struct ScheduleDayView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                SubjectView(isFirstSubjectOfTheDay: true, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
                SubjectView(isFirstSubjectOfTheDay: false, startTime: "11:35", endTime: "13:05", subjectName: "Mathematics", teacherName: "Brooklyn Williamson", classroom: "Room 6-205", group: "972101", isCurrent: false, subjectNumberInQueue: 1)
            }
            Spacer().frame(height: 20)
        }
        .padding([.leading, .trailing], 20)
    }
}

struct ScheduleDayView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDayView()
    }
}
