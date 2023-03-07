//
//  ClassViw.swift
//  Schedule
//
//  Created by admin on 16.02.2023.
//

import SwiftUI

struct SubjectView: View {
    
    var startTime: String
    var endTime: String
    var subjectName: String
    var subjectType: String
    var teacherName: String
    var classroom: String
    var group: String
    var isCurrent: Bool
    var subjectNumberInQueue: Int
    @State var isDescendingOrder: Bool = true
    
    var textColor: Color {
        isCurrent ? Color.white : Color.dayOfMonthColor
    }
    var backgroundRectangleColor: Color {
        isCurrent ? Color.backgroundCurrentSubjectColor : Color.backgroundNotCurrentSubjectColor
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Spacer().frame(height: 5)
                Text(startTime)
                    .foregroundColor(.dayOfMonthColor)
                    .font(.custom("Poppins-Medium", size: 17))
                Text(endTime)
                    .foregroundColor(.softGray)
                    .font(.custom("Poppins-Medium", size: 15))
            }
            .frame(width: 50, alignment: .leading)
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Text(subjectName)
                        .font(.custom("Poppins-SemiBold", size: 18))
                    Spacer()
//                    Text(String(subjectNumberInQueue))
                }
                Spacer().frame(height: 0)
                AboutSubjectData(iconName: "person.2", textInfo: group)
                AboutSubjectData(iconName: "house", textInfo: classroom)
                AboutSubjectData(iconName: "graduationcap", textInfo: teacherName)
                AboutSubjectData(iconName: "questionmark.circle", textInfo: subjectType)
            }
            .foregroundColor(GetColorBySubjectType().getTextColor(subjectType: subjectType))
            .padding([.leading, .trailing], 20)
            .padding([.top, .bottom], 15)
            .background(RoundedRectangle(cornerRadius: 16).fill(GetColorBySubjectType().getBackgroundColor(subjectType: subjectType)))
        }
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView(
            startTime: "09:45",
            endTime: "13:05",
            subjectName: "Матан",
            subjectType: "Лекция",
            teacherName: "Brooklyn Williamson",
            classroom: "Room 6-205",
            group: "972101",
            isCurrent: false,
            subjectNumberInQueue: 2
            
        )
    }
}
