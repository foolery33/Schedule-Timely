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
    
    private let baseURL: String = "http://timely.markridge.space"
    
    enum ProfileError: Error, LocalizedError, Identifiable {
        
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
                    print("Fail")
                    completion(.failure(.profileError(.serverError)))
                }
            case .failure(_):
                completion(.failure(.profileError(.serverError)))
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
