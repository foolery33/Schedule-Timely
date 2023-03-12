//
//  ScheduleApp.swift
//  Schedule
//
//  Created by admin on 13.02.2023.
//

import SwiftUI

@main
struct ScheduleApp: App {
    
    @StateObject var viewModel = GeneralViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if(viewModel.isValidated) {
                    MainScreen(viewModel: viewModel.mainScreenViewModel)
                }
                else {
                    LoginScreen(viewModel: viewModel.loginScreenViewModel)
                }
            }
            .environmentObject(viewModel)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                if(!viewModel.loginScreenViewModel.rememberPassword) {
                    UserStorage.shared.clearAllData()
                }
            }
        }
    }
}
