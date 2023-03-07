//
//  ErrorsHandler.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation

enum ViewModelType {
    
    case authentication
    case profile
    case search
    case schedule
    
}

enum AppError: Error, LocalizedError, Identifiable, Equatable {
    
    case authenticationError(AuthenticationViewModel.AuthenticationError)
    case profileError(ProfileViewModel.ProfileError)
    case searchError(SearchViewModel.SearchError)
    case scheduleError(ScheduleViewModel.ScheduleError)
    
    var id: String {
        self.errorDescription
    }
    
    var errorDescription: String {
        switch self {
        case .authenticationError(let error):
            return error.errorDescription
        case .profileError(let error):
            return error.errorDescription
        case .searchError(let error):
            return error.errorDescription
        case .scheduleError(let error):
            return error.errorDescription
        }
    }
    
}
