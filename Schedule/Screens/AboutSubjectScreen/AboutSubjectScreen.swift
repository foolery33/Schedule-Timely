//
//  AboutSubjectScreen.swift
//  Schedule
//
//  Created by admin on 25.02.2023.
//

import SwiftUI

struct AboutSubjectScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: AboutSubjectScrenViewModel
    @Environment(\.dismiss) var dismiss
    let subjectName: String
    let subjectType: String
    let startTime: String
    let endTime: String
    let teacherName: String
    let roomName: String
    let groupName: String
    
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
                Text("About the subject")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Poppins-Bold", size: 17))
            }
            .padding([.leading, .trailing], 0)
            .foregroundColor(.dayOfMonthColor)
            Spacer().frame(height: 50)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(subjectName)
                        .foregroundColor(.dayOfMonthColor)
                        .font(.custom("Poppins-Bold", size: 23))
                    Spacer()
                }
                Text(subjectType)
                    .font(.custom("Poppins-Semibold", size: 15))
                    .foregroundColor(GetColorBySubjectType().getTextColor(subjectType: subjectType))
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 5)
                    .background(RoundedRectangle(cornerRadius: 4).fill(GetColorBySubjectType().getBackgroundColor(subjectType: subjectType)))
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
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.dayOfMonthColor)
                }
                .onTapGesture {
                    loadClassroomList()
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
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.dayOfMonthColor)
                }
                .onTapGesture {
                    loadTeacherList()
                }
            }
            .padding([.leading, .trailing], 20)
            Spacer()
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Data Loading"), message: Text(error.errorDescription))
        }
    }
    
    func loadClassroomList() {
        if(generalViewModel.classroomPickerScreenViewModel.classroomList.isEmpty) {
            generalViewModel.classroomPickerScreenViewModel.getClassroomList { success in
                if(success) {
                    generalViewModel.scheduleType = .classroom
                    generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
                    generalViewModel.mainScreenId += 1
                    generalViewModel.mainScreenViewModel.showContent = false
                    generalViewModel.classroomId = FindClassroomIdByName().find(name: roomName, in: generalViewModel.classroomPickerScreenViewModel.classroomList)
                    print(generalViewModel.classroomId)
                }
            }
        }
        else {
            generalViewModel.scheduleType = .classroom
            generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
            generalViewModel.mainScreenId += 1
            generalViewModel.mainScreenViewModel.showContent = false
            generalViewModel.classroomId = FindClassroomIdByName().find(name: roomName, in: generalViewModel.classroomPickerScreenViewModel.classroomList)
            print(generalViewModel.classroomId)
        }
    }
    
    func loadTeacherList() {
        if(generalViewModel.teacherPickerScreenViewModel.teacherList.isEmpty) {
            generalViewModel.teacherPickerScreenViewModel.getTeacherList { success in
                if(success) {
                    print("teacher transition")
                    generalViewModel.scheduleType = .teacher
                    generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
                    generalViewModel.mainScreenId += 1
                    generalViewModel.mainScreenViewModel.showContent = false
                    generalViewModel.teacherId = FindTeacherIdByName().find(name: teacherName, in: generalViewModel.teacherPickerScreenViewModel.teacherList)
                    print(generalViewModel.teacherId)
                }
            }
        }
        else {
            generalViewModel.scheduleType = .teacher
            generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
            generalViewModel.mainScreenId += 1
            generalViewModel.mainScreenViewModel.showContent = false
            generalViewModel.teacherId = FindTeacherIdByName().find(name: teacherName, in: generalViewModel.teacherPickerScreenViewModel.teacherList)
            print(generalViewModel.teacherId)
        }
    }
    
}

struct AboutSubjectScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutSubjectScreen(
            viewModel: AboutSubjectScrenViewModel(),
            subjectName: "Математика",
            subjectType: "Лекция",
            startTime: "11:00",
            endTime: "12:00",
            teacherName: "Даммер Диана Дамировна",
            roomName: "Online",
            groupName: "972101")
    }
}
