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
                ProfileScreen()
            }
            .environmentObject(viewModel)
        }
    }
}
