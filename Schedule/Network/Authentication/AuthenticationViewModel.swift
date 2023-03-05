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
        case noCredentials
        case invalidCredentials
        case serverError
        case invalidName
        case invalidEmail
        case shortPassword
        case longPassword
        case noLowercaseSymbol
        case noUppercaseSymbol
        case noNonAlphanumericSymbol
        case noDigitSymbol
        case differentPasswords
        case emailExists
        case unauthorized
        
        var id: String {
            self.errorDescription
        }
        
        var errorDescription: String {
            switch self {
            case .noCredentials:
                return NSLocalizedString("Please make sure that you've provided all necessary data", comment: "")
            case .invalidCredentials:
                return NSLocalizedString("Either your email or password are incorrect. Please try again", comment: "")
            case .serverError:
                return NSLocalizedString("Some server error occured. Please try again or contact developer", comment: "")
            case .invalidName:
                return NSLocalizedString("Full name must consist of 2-3 words with at least 2 symbols in them. Words should contain only lati or cyrillic symbols and start with a capital letter", comment: "")
            case .invalidEmail:
                return NSLocalizedString("Such email does not exist. Please make sure you entered a correct email", comment: "")
            case .shortPassword:
                return NSLocalizedString("Password must contain at least 8 symbols", comment: "")
            case .longPassword:
                return NSLocalizedString("Password must contain a maximum of 64 symbols", comment: "")
            case .noLowercaseSymbol:
                return NSLocalizedString("Password must contain at least one lowercase symbol", comment: "")
            case .noUppercaseSymbol:
                return NSLocalizedString("Password must contain at least one uppercase symbol", comment: "")
            case .noNonAlphanumericSymbol:
                return NSLocalizedString("Password must contain at least one non alphanumeric symbol: -_!@#№$%^&?*+=(){}[]<>~", comment: "")
            case .noDigitSymbol:
                return NSLocalizedString("Password must contain at least one digit", comment: "")
            case .differentPasswords:
                return NSLocalizedString("Please make sure that 'password' and 'confirm password' fields contain the same values", comment: "")
            case .emailExists:
                return NSLocalizedString("User with such email already exists", comment: "")
            case .unauthorized:
                return NSLocalizedString("Your token is expired. Please login again", comment: "")
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Bool, AuthenticationViewModel.AuthenticationError>) -> Void) {
        DispatchQueue.main.async {
            if(email == "" || password == "") {
                completion(.failure(.noCredentials))
                return
            }
            
            let httpParameters: [String: String] = [
                "email": email,
                "password": password
            ]
            let url = self.baseURL + "/api/account/login"
            print(email, password)
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate(statusCode: 200..<300).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(TokenResponseModel.self, from: data)
                        TokenManager.shared.saveData(email: email, password: password, accessToken: decodedData.token ?? "")
                        completion(.success(true))
                    } catch(_) {
                        completion(.failure(.serverError))
                    }
                case .failure(_):
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
                        case 400, 401:
                            completion(.failure(.invalidCredentials))
                        default:
                            completion(.failure(.serverError))
                        }
                    }
                    else {
                        completion(.failure(.serverError))
                    }
                }
            }
        }
        
    }
    
    func register(email: String, password: String, confirmPassword: String, completion: @escaping (Result<Bool, AuthenticationViewModel.AuthenticationError>) -> Void) {
        DispatchQueue.main.async {
            
            if(email == "" || password == "" || confirmPassword == "") {
                completion(.failure(.noCredentials))
                return
            }
            
            if(password != confirmPassword) {
                completion(.failure(.differentPasswords))
                return
            }
            
            let httpParameters: [String: String] = [
                "fullName": "Some Username", // в мобильной версии не нужно использовать этот параметр, поэтому он будет стандартным для всех пользователей
                "password": password,
                "email": email
            ]
            let url = self.baseURL + "/api/account/register"
            print(email, password)
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).responseData { response in
                if let requestStatusCode = response.response?.statusCode {
                    print("requestStatusCode: ", requestStatusCode)
                }
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(TokenResponseModel.self, from: data)
                        TokenManager.shared.saveData(email: email, password: password, accessToken: decodedData.token ?? "")
                        completion(.success(true))
                    } catch(_) {
                        if let passwordValidationResult = PasswordValidation().isValidPassword(password) {
                            completion(.failure(passwordValidationResult))
                        }
                        else {
                            if let requestStatusCode = response.response?.statusCode {
                                switch requestStatusCode {
                                case 400:
                                    completion(.failure(.invalidEmail))
                                case 409:
                                    completion(.failure(.emailExists))
                                default:
                                    completion(.failure(.serverError))
                                }
                            }
                        }
                    }
                case .failure(_):
                    completion(.failure(.serverError))
                }
            }
        }
    }
    
    func logout(completion: @escaping (Result<Bool, AuthenticationViewModel.AuthenticationError>) -> Void) {
        let url = self.baseURL + "/api/account/logout"
        AF.request(url, method: .post, interceptor: self.interceptor).validate(statusCode: 200..<300).responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print(requestStatusCode)
            }
            switch response.result {
            case .success(_):
                do {
                    completion(.success(true))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.success(true))
                    default:
                        completion(.failure(.serverError))
                    }
                }
                else {
                    completion(.failure(.serverError))
                }
            }
        }
    }
    
}
