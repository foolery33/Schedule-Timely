//
//  GroupPickerScreen.swift
//  Schedule
//
//  Created by admin on 19.02.2023.
//

import SwiftUI

struct ClassroomPickerScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: ClassroomPickerScreenViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var isGuest: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    Image(systemName: "chevron.backward")
                        .padding(.leading, 10)
                        .font(.system(size: 16, weight: .medium))
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                    Text("Groups")
                        .frame(maxWidth: .infinity)
                        .font(.custom("Poppins-Bold", size: 17))
                }
                .foregroundColor(.dayOfMonthColor)
                Spacer().frame(height: 30)
                SearchingTextField(text: $viewModel.classroomText, header: "Find your classroom", placeholderText: "Classroom number")
                    .padding([.leading, .trailing], 20)
                
                Spacer().frame(height: 20)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        Spacer().frame(height: 10)
                        let classroomTextedList = MakeList().makeList(from: viewModel.classroomList)
                        ForEach(viewModel.classroomText.isEmpty ? classroomTextedList : classroomTextedList.filter {$0.contains(viewModel.classroomText)}, id: \.self) { classroom in
                            ListRow(text: classroom)
                                .onTapGesture {
                                    if(isGuest) {
                                        viewModel.toggleValidationStatusClosure(true)
                                    }
                                    generalViewModel.scheduleType = .classroom
                                    generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
                                    generalViewModel.mainScreenId += 1
                                    generalViewModel.mainScreenViewModel.showContent = false
                                    generalViewModel.classroomId = FindClassroomIdByName().find(name: classroom, in: viewModel.classroomList)
                                    print(generalViewModel.classroomId)
                                }
//                            if(isGuest) {
//                                NavigationLink(destination: MainScreen(viewModel: generalViewModel.mainScreenViewModel).onAppear {
//                                    generalViewModel.mainScreenId += 1
//                                    generalViewModel.mainScreenViewModel.classroomId = FindClassroomIdByName().find(name: classroom, in: viewModel.classroomList)
//                                    generalViewModel.mainScreenViewModel.showContent = false
//                                    generalViewModel.scheduleType = .classroom
//                                    generalViewModel.resetMainScreenViewModel()
//                                }.navigationBarBackButtonHidden()) {
//                                    ListRow(text: classroom)
//                                }
//                                .buttonStyle(NoHighlightButtonStyle())
//                            }
//                            else {
//                                ListRow(text: classroom)
//                                    .onTapGesture {
//                                        generalViewModel.scheduleType = .classroom
//                                        generalViewModel.mainScreenViewModel = generalViewModel.getMainScreenViewModel()
//                                        generalViewModel.mainScreenId += 1
//                                        generalViewModel.mainScreenViewModel.showContent = false
//                                        generalViewModel.mainScreenViewModel.classroomId = FindClassroomIdByName().find(name: classroom, in: viewModel.classroomList)
//                                        print(generalViewModel.mainScreenViewModel.classroomId)
//                                    }
//                            }
                            
                        }
                        Spacer().frame(height: 20)
                    }
                }
                .background(Color.softWhite)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .edgesIgnoringSafeArea(.bottom)
            }
            .padding([.top, .bottom], 20)
            .edgesIgnoringSafeArea(.bottom)
            .opacity(viewModel.showContent ? 1 : 0)
            if(viewModel.showProgressView) {
                Rectangle().fill(Color.white.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        }
        .onAppear {
            viewModel.getClassroomList { success in
                
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Loading"), message: Text(error.errorDescription))
        }
        .onDisappear {
            viewModel.classroomText = ""
        }
    }
}

//struct GroupPickerScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupPickerScreen(viewModel: GroupPickerScreenViewModel(), goToNextScreen: false)
//            .environmentObject(GeneralViewModel())
//    }
//}
