//
//  AboutSubjectScreen.swift
//  Schedule
//
//  Created by admin on 25.02.2023.
//

import SwiftUI

struct AboutSubjectScreen: View {
    
    @Environment(\.dismiss) var dismiss
    var subjectName: String = "Тестирование программного обеспечения"
    var startTime: String = "12:25"
    var endTime: String = "14:00"
    var teacherName: String = "Волков Максим Николаевич"
    var roomName: String = "Онлайн"
    var groupName: String = "972101"
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 20)
            ZStack(alignment: .leading) {
                Image(systemName: "chevron.backward")
                    .padding(.leading, 10)
                    .font(.system(size: 16, weight: .medium))
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                Text("About subject")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Poppins-Bold", size: 17))
            }
            .padding([.leading, .trailing], 0)
            .foregroundColor(.dayOfMonthColor)
            Spacer().frame(height: 50)
            VStack(alignment: .leading, spacing: 6) {
                Text(subjectName)
                    .foregroundColor(.dayOfMonthColor)
                    .font(.custom("Poppins-Bold", size: 23))
                Text("Лекция")
            }
            .padding([.leading, .trailing], 20)
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 34)
                HStack(spacing: 12) {
                    Image(systemName: "clock")
                        .frame(width: 20, alignment: .center)
                        .foregroundColor(.darkGreenColor)
                    Text("\(startTime) - \(endTime)")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.dayOfMonthColor)
                    Spacer()
                }
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 0.6, dash: [1, 1]))
                    .frame(width: 1, height: 34)
                    .padding(.leading, 9.5)
                    .foregroundColor(.darkGreenColor)
                HStack(spacing: 12) {
                    Image(systemName: "person.2")
                        .frame(width: 20, alignment: .center)
                        .foregroundColor(.darkGreenColor)
                    Text(groupName)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.dayOfMonthColor)
                    Spacer()
                }
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 0.6, dash: [1, 1]))
                    .frame(width: 1, height: 34)
                    .padding(.leading, 9.5)
                    .foregroundColor(.darkGreenColor)
                HStack(spacing: 12) {
                    Image(systemName: "house")
                        .frame(width: 20, alignment: .center)
                        .foregroundColor(.darkGreenColor)
                    Text(roomName)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.dayOfMonthColor)
                    Spacer()
                }
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 0.6, dash: [1, 1]))
                    .frame(width: 1, height: 34)
                    .padding(.leading, 9.5)
                    .foregroundColor(.darkGreenColor)
                HStack(spacing: 12) {
                    Image(systemName: "graduationcap")
                        .frame(width: 20, alignment: .center)
                        .foregroundColor(.darkGreenColor)
                    Text(teacherName)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.dayOfMonthColor)
                    Spacer()
                }
            }
            .padding([.leading, .trailing], 20)
            Spacer()
        }
    }
}

struct AboutSubjectScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutSubjectScreen()
    }
}
