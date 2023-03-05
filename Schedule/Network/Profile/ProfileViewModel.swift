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
    
    func getProfile(completion: @escaping (Result<ProfileModel, ProfileViewModel.ProfileError>) -> Void) {
        let url = self.baseURL + "/api/accout/profile"
        AF.request(url, interceptor: self.interceptor).responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print(requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
                        case 200:
                            let decodedData = try JSONDecoder().decode(ProfileModel.self, from: data)
                            completion(.success(decodedData))
                        case 401:
                            completion(.failure(.unauthorized))
                        default:
                            completion(.failure(.serverError))
                        }
                    }
                } catch(_) {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
        
    }
    
}
