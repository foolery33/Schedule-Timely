//
//  ProfileViewModel.swift
//  Schedule
//
//  Created by admin on 04.03.2023.
//

import Foundation
import Alamofire
import SwiftUI

class ProfileViewModel {
    
    static let shared = ProfileViewModel()
    
    private let interceptor: CustomRequestInterceptor = CustomRequestInterceptor()
    
    private let baseURL: String = "https://timely.markridge.space"
    
    enum ProfileError: Error, LocalizedError, Identifiable {
        
        case unauthorized
        case serverError
        case contactDeveloper
        case invalidName
        case invalidAvatar
        
        var id: String {
            self.errorDescription
        }
        
        var errorDescription: String {
            switch self {
            case .unauthorized:
                return NSLocalizedString("Your token is expired. Please login again", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again or contact developer", comment: "")
            case .contactDeveloper:
                return NSLocalizedString("Some programming problem. Please contact developer", comment: "")
            case .invalidName:
                return NSLocalizedString("Full name must consist of 2-3 words with at least 2 symbols in them. Words should contain only latin or cyrillic symbols and start with a capital letter", comment: "")
            case .invalidAvatar:
                return NSLocalizedString("Your avatar link is corrupted. Please enter the correct one", comment: "")
            }
        }
        
    }
    
    func getProfile(completion: @escaping (Result<ProfileModel, AppError>) -> Void) {
        let url = self.baseURL + "/api/account/profile"
        AF.request(url, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get Profile Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(ProfileModel.self, from: data)
                    completion(.success(decodedData))
                } catch(_) {
                    completion(.failure(.profileError(.contactDeveloper)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.profileError(.unauthorized)))
                    case 500:
                        completion(.failure(.profileError(.serverError)))
                    default:
                        completion(.failure(.profileError(.serverError)))
                    }
                }
                else {
                    completion(.failure(.profileError(.serverError)))
                }
            }
        }
    }
    
    func changeProfile(fullName: String, completion: @escaping (Result<Bool, AppError>) -> Void) {
        let url = self.baseURL + "/api/account/profile"
        let httpParameters: [String: String] = [
            "fullName": fullName
        ]
        AF.request(url, method: .put, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Set Profile Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.profileError(.invalidName)))
                    case 401:
                        completion(.failure(.profileError(.unauthorized)))
                    default:
                        completion(.failure(.profileError(.serverError)))
                    }
                }
            }
        }
    }
    
    func setAvatar(avatarLink: String, completion: @escaping (Result<String, AppError>) -> Void) {
        let url = self.baseURL + "/api/account/avatar/set"
        let httpParameters: [String: String] = [
            "avatarLink": avatarLink
        ]
        AF.request(url, method: .put, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Set Avatar Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(_):
                completion(.success(avatarLink))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.profileError(.invalidAvatar)))
                    case 401:
                        completion(.failure(.profileError(.unauthorized)))
                    default:
                        completion(.failure(.profileError(.serverError)))
                    }
                }
            }
        }
    }
    
}
