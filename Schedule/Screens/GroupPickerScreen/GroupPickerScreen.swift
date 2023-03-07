//
//  GroupPickerScreen.swift
//  Schedule
//
//  Created by admin on 19.02.2023.
//

import SwiftUI

struct GroupPickerScreen: View {
    
    @EnvironmentObject var generalViewModel: GeneralViewModel
    @ObservedObject var viewModel: GroupPickerScreenViewModel
    
    @Environment(\.dismiss) var dismiss
    var goToNextScreen: Bool
    
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
                SearchingTextField(text: $viewModel.groupText, header: "Find your group", placeholderText: "Group number")
                    .padding([.leading, .trailing], 20)
                
                Spacer().frame(height: 20)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        Spacer().frame(height: 10)
                        let groupTextedList = MakeList().makeList(from: viewModel.groupList)
                        ForEach(viewModel.groupText.isEmpty ? groupTextedList : groupTextedList.filter {$0.contains(viewModel.groupText)}, id: \.self) { group in
                            if(goToNextScreen) {
                                NavigationLink(destination: MainScreen(viewModel: generalViewModel.mainScreenViewModel).navigationBarBackButtonHidden()) {
                                    ListRow(text: group)
                                }
                                .buttonStyle(NoHighlightButtonStyle())
                            }
                            else {
                                ListRow(text: group)
                                    .frame(width: UIScreen.main.bounds.size.width)
                                    .onTapGesture {
                                        print("tapped")
                                        generalViewModel.registerScreenViewModel.selectedRole = 0
                                        generalViewModel.registerScreenViewModel.group.name = group
                                        generalViewModel.registerScreenViewModel.teacher = TeacherListElementModel(id: "")
                                        generalViewModel.registerScreenViewModel.group.id = FindGroupIdByName().find(name: group, in: viewModel.groupList)
                                        dismiss()
                                    }
                            }
                            
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
            viewModel.getGroupList { success in
                
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Loading"), message: Text(error.errorDescription))
        }
    }
}

//struct GroupPickerScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupPickerScreen(viewModel: GroupPickerScreenViewModel(), goToNextScreen: false)
//            .environmentObject(GeneralViewModel())
//    }
//}
