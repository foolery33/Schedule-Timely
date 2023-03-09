//
//  SearchViewModel.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation
import Alamofire

class SearchViewModel {
    
    static let shared = SearchViewModel()
    
    private let interceptor: CustomRequestInterceptor = CustomRequestInterceptor()
    
    private let baseURL: String = "https://timely.markridge.space"
    
    enum SearchError: Error, LocalizedError, Identifiable {
        case unauthorized
        case serverError
        
        var id: String {
            self.errorDescription
        }
        
        var errorDescription: String {
            switch self {
            case .unauthorized:
                return NSLocalizedString("Your token is expired. Please login again", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again or contact developer", comment: "")
            }
        }
    }
    
    func getGroupList(completion: @escaping (Result<[GroupListElementModel], AppError>) -> Void) {
        let url = self.baseURL + "/api/search/groups"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let responseStatusCode = response.response?.statusCode {
                print("Get Group List Status Code: ", responseStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([GroupListElementModel].self, from: data)
                    completion(.success(decodedData))
                } catch (_) {
                    completion(.failure(.searchError(.serverError)))
                }
            case .failure(_):
                completion(.failure(.searchError(.serverError)))
            }
        }
    }
    
    func getTeacherList(completion: @escaping (Result<[TeacherListElementModel], AppError>) -> Void) {
        let url = self.baseURL + "/api/search/teachers"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let responseStatusCode = response.response?.statusCode {
                print("Get Teacher List Status Code: ", responseStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([TeacherListElementModel].self, from: data)
                    completion(.success(decodedData))
                } catch (_) {
                    completion(.failure(.searchError(.serverError)))
                }
            case .failure(_):
                completion(.failure(.searchError(.serverError)))
            }
        }
    }
    
    func getClassroomList(completion: @escaping (Result<[ClassroomModel], AppError>) -> Void) {
        let url = self.baseURL + "/api/search/classrooms"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let responseStatusCode = response.response?.statusCode {
                print("Get Classroom List Status Code: ", responseStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([ClassroomModel].self, from: data)
                    completion(.success(decodedData))
                } catch (_) {
                    completion(.failure(.searchError(.serverError)))
                }
            case .failure(_):
                completion(.failure(.searchError(.serverError)))
            }
        }
    }
    
}
