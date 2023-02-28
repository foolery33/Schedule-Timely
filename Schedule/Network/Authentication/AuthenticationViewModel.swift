//
//  AuthenticationViewModel.swift
//  Schedule
//
//  Created by admin on 27.02.2023.
//

import Foundation
import Alamofire

class AuthenticationViewModel {
    
    static let shared = AuthenticationViewModel()
    
    private let interceptor: CustomRequestInterceptor = CustomRequestInterceptor()
    
    private let baseURL: String = "http://timely.markridge.space"
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case serverError
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Either your email or password are incorrect. Please try again", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again or contact developer", comment: "")
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Bool, AuthenticationViewModel.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let httpParameters: [String: String] = [
                "email": email,
                "password": password
            ]
            let url = self.baseURL + "/api/account/login"
            print(url)
            print(email, password)
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        print("Success")
                        let decodedData = try JSONDecoder().decode(TokenResponseModel.self, from: data)
                        TokenManager.shared.saveData(email: email, password: password, accessToken: decodedData.token ?? "")
                        completion(.success(true))
                    } catch(_) {
                        completion(.failure(.serverError))
                    }
                case .failure(_):
                    completion(.failure(.invalidCredentials))
                }
            }
        }
        
    }
    
}
