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
        case notTeacherEmail
        case studentCantBeTeacher
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
            case .notTeacherEmail:
                return NSLocalizedString("Teacher email must contain yandex.ru as a domain", comment: "")
            case .studentCantBeTeacher:
                return NSLocalizedString("Only teacher email can contain yandex.ru as a domain", comment: "")
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
    
    func login(email: String, password: String, completion: @escaping (Result<TokenResponseModel, AppError>) -> Void) {
        DispatchQueue.main.async {
            if(email == "" || password == "") {
                completion(.failure(.authenticationError(.noCredentials)))
                return
            }
            
            let httpParameters: [String: String] = [
                "email": email,
                "password": password
            ]
            let url = self.baseURL + "/api/account/login"
            print(email, password)
            AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate(statusCode: 200..<300).responseData { response in
                if let requestStatusCode = response.response?.statusCode {
                    print("Login Status Code: ", requestStatusCode)
                }
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(TokenResponseModel.self, from: data)
                        UserStorage.shared.saveProfileData(email: email, password: password, accessToken: decodedData.token ?? "")
                        completion(.success(decodedData))
                    } catch(_) {
                        completion(.failure(.authenticationError(.serverError)))
                    }
                case .failure(_):
                    if let requestStatusCode = response.response?.statusCode {
                        switch requestStatusCode {
                        case 400, 401:
                            completion(.failure(.authenticationError(.invalidCredentials)))
                        default:
                            completion(.failure(.authenticationError(.serverError)))
                        }
                    }
                    else {
                        completion(.failure(.authenticationError(.serverError)))
                    }
                }
            }
        }
        
    }
    
    func register(email: String, password: String, confirmPassword: String, completion: @escaping (Result<Bool, AppError>) -> Void) {
        DispatchQueue.main.async {
            
            if(email == "" || password == "" || confirmPassword == "") {
                completion(.failure(.authenticationError(.noCredentials)))
                return
            }
            
            if(password != confirmPassword) {
                completion(.failure(.authenticationError(.differentPasswords)))
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
                        UserStorage.shared.saveProfileData(email: email, password: password, accessToken: decodedData.token ?? "")
                        completion(.success(true))
                    } catch(_) {
                        if let passwordValidationResult = PasswordValidation().isValidPassword(password) {
                            completion(.failure(.authenticationError(passwordValidationResult)))
                        }
                        else {
                            if let requestStatusCode = response.response?.statusCode {
                                switch requestStatusCode {
                                case 400:
                                    completion(.failure(.authenticationError(.invalidEmail)))
                                case 409:
                                    completion(.failure(.authenticationError(.emailExists)))
                                default:
                                    completion(.failure(.authenticationError(.serverError)))
                                }
                            }
                        }
                    }
                case .failure(_):
                    completion(.failure(.authenticationError(.serverError)))
                }
            }
        }
    }
    
    func logout(completion: @escaping (Result<Bool, AppError>) -> Void) {
        let url = self.baseURL + "/api/account/logout"
        AF.request(url, method: .post, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Logout Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(_):
                do {
                    completion(.success(true))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401, 500:
                        completion(.success(true))
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
    
    func setGroup(group: String, completion: @escaping (Result<Bool, AppError>) -> Void) {
        let url = self.baseURL + "/api/account/group/set"
        let httpParameters: [String: String] = [
            "groupId": group
        ]
        print("groupId: ", group)
        AF.request(url, method: .put, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Set Group Status Code: ", requestStatusCode)
            }
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 401:
                        completion(.failure(.authenticationError(.unauthorized)))
                    default:
                        completion(.failure(.authenticationError(.serverError)))
                    }
                }
            }
        }
    }
    
}
