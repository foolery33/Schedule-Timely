//
//  ScheduleDayView.swift
//  Schedule
//
//  Created by admin on 21.02.2023.
//

import SwiftUI

struct ScheduleDayView: View {
    
    var lessons: [LessonModel]
    
    var body: some View {
    
        if(lessons.isEmpty) {
            VStack(spacing: 0) {
                Image("Hang-Out")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 240)
                    .opacity(0.9)
                Spacer().frame(height: 8)
                Text("Free day...")
                    .foregroundColor(.dayOfMonthColor)
                    .font(.custom("Poppins-Semibold", size: 20))
                Text("A good opportunity to meet your friends")
                    .foregroundColor(.dayOfMonthColor)
                    .font(.custom("Poppins-Regular", size: 15))
                Spacer().frame(height: 120)
            }
        }
        else {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 16) {
                    ForEach(0..<lessons.count, id: \.self) { index in
                        NavigationLink(destination: AboutSubjectScreen(
                            subjectName: lessons[index].name.name,
                            subjectType: lessons[index].tag.name,
                            startTime: ConvertDateToHourMinute().convert(lessons[index].timeInterval.startTime),
                            endTime: ConvertDateToHourMinute().convert(lessons[index].timeInterval.endTime),
                            teacherName: lessons[index].teacher.name,
                            roomName: lessons[index].classroom.name,
                            groupName: getGroupString(lesson: lessons[index])).navigationBarBackButtonHidden(true)) {
                            SubjectView(
                                startTime: ConvertDateToHourMinute().convert(lessons[index].timeInterval.startTime),
                                endTime: ConvertDateToHourMinute().convert(lessons[index].timeInterval.endTime),
                                subjectName: lessons[index].name.name,
                                subjectType: lessons[index].tag.name,
                                teacherName: lessons[index].teacher.name,
                                classroom: lessons[index].classroom.name,
                                group: getGroupString(lesson: lessons[index]),
                                isCurrent: false,
                                subjectNumberInQueue: 1)
                        }
                        .buttonStyle(NoHighlightButtonStyle())
                    }
                }
                Spacer().frame(height: 106)
            }
            .padding([.leading, .trailing], 20)
        }
    }
    
    func getGroupString(lesson: LessonModel) -> String {
        var groups: [String] = []
        var result = ""
        for group in 0..<lesson.group.count {
            groups.append(lesson.group[group].name)
        }
        groups = groups.sorted()
        for i in 0..<groups.count {
            result += groups[i]
            if(i != groups.count - 1) {
                result += ", "
            }
        }
        return result
    }
    
}

struct ScheduleDayView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDayView(lessons: [LessonModel(name: LessonNameModel(name: "Mathematics"), tag: LessonTagModel(name: "Lection"), group: [GroupModel(name: "972101")], teacher: TeacherModel(name: "Some teacher"), timeInterval: TimeIntervalModel(startTime: "08:08:08", endTime: "09:09:09"), classroom: ClassroomModel(name: "Online"), date: "909090")])
    }
}
