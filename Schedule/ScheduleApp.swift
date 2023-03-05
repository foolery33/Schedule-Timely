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
            NavigationStack {
                if(viewModel.isValidated) {
                    MainScreen(viewModel: viewModel.mainScreenViewModel)
                }
                else {
                    LoginScreen(viewModel: viewModel.loginScreenViewModel)
                }
            }
            .environmentObject(viewModel)
//            .onAppear {
//                NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { _ in
//                    print("Yes")
//                    // ваш код, который будет выполнен при полном закрытии приложения
//                    if(!viewModel.loginScreenViewModel.rememberPassword) {
//                        TokenManager.shared.clearToken()
//                        print("Yea")
//                    }
//                }
//            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                print(viewModel.loginScreenViewModel.rememberPassword)
                if(!viewModel.loginScreenViewModel.rememberPassword) {
                    TokenManager.shared.clearToken()
                    print("Yea")
                }
            }
        }
    }
}
