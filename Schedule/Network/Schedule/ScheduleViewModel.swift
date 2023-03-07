//
//  ScheduleViewModel.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation
import Alamofire

class ScheduleViewModel: LoadingDataClass {
    
    static let shared = ScheduleViewModel()
    
    private let interceptor: CustomRequestInterceptor = CustomRequestInterceptor()
    
    private let baseURL: String = "http://timely.markridge.space"
    
    enum ScheduleError: Error, LocalizedError, Identifiable {
        case unauthorized
        case contactDeveloper
        case invalidGroupId
        case invalidDate
        case serverError
        
        var id: String {
            self.errorDescription
        }
        
        var errorDescription: String {
            switch self {
            case .unauthorized:
                return NSLocalizedString("Your token is expired. Please login again", comment: "")
            case .contactDeveloper:
                return NSLocalizedString("Some programming problem. Please contact developer", comment: "")
            case .invalidGroupId:
                return NSLocalizedString("Group with this id does not exist", comment: "")
            case .invalidDate:
                return NSLocalizedString("Invalid date value", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again or contact developer", comment: "")
            }
        }
    }
    
    func getGroupSchedule(date: String, groupId: String, completion: @escaping (Result<[LessonModel], AppError>) -> Void) {
        DispatchQueue.main.async {
            let url = self.baseURL + "/api/schedule/group/\(groupId)"
            let httpParameters: [String: String] = [
                "date": date
            ]
            AF.request(url, parameters: httpParameters, encoding: URLEncoding.queryString, interceptor: self.interceptor).validate().responseData { response in
                if let requestStatusCode = response.response?.statusCode {
                    print("Get Schedule Status Code: ", requestStatusCode)
                }
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode([LessonModel].self, from: data)
                        completion(.success(decodedData))
                    } catch (_) {
                        completion(.failure(.scheduleError(.contactDeveloper)))
                    }
                case .failure(_):
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
                        case 400:
                            completion(.failure(.scheduleError(.invalidDate)))
                        case 404:
                            completion(.failure(.scheduleError(.invalidGroupId)))
                        default:
                            completion(.failure(.scheduleError(.serverError)))
                        }
                    }
                    else {
                        completion(.failure(.scheduleError(.serverError)))
                    }
                }
            }
        }
    }
    
}
