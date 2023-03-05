//
//  CustomRequestInterceptor.swift
//  Schedule
//
//  Created by admin on 27.02.2023.
//

import Foundation
import Alamofire

class CustomRequestInterceptor: RequestInterceptor {
    private let retryLimit = 5
    private let retryDelay: TimeInterval = 10
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if !TokenManager.shared.fetchAccessToken().isEmpty {
            urlRequest.setValue("Bearer \(TokenManager.shared.fetchAccessToken())", forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = (request.task?.response as? HTTPURLResponse)?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        switch statusCode {
//        case 401:
//            refreshToken { [weak self] in
//                guard let self,
//                      request.retryCount < self.retryLimit else { return }
//                completion(.retryWithDelay(self.retryDelay))
//            }
        case (500...599):
            guard request.retryCount < retryLimit else { return }
            completion(.retryWithDelay(retryDelay))
        default:
            completion(.doNotRetry)
        }
    }
    
//    private func refreshToken(completion: @escaping (() -> Void)) {
//        print("refresh")
//        let httpParameters: [String: String] = [
//            "userName": TokenManager.shared.fetchEmail(),
//            "password": TokenManager.shared.fetchPassword()
//        ]
//        let url = "https://react-midterm.kreosoft.space/api/account/login"
//        AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    print("succ")
//                    let decodedData = try JSONDecoder().decode(TokenModel.self, from: data)
//                    //TokenManager.shared.saveAccessToken(accessToken: accessToken.token)
//                    TokenManager.shared.saveData(email: TokenManager.shared.fetchEmail(), password: TokenManager.shared.fetchPassword(), accessToken: decodedData.token)
//                    print(TokenManager.shared.fetchAccessToken())
//                    completion()
//                } catch(let error) {
//                    print("Error: ", error)
//                    completion()
//                    return
//                }
//            case .failure(let error):
//                print("Error: ", error)
//                completion()
//                return
//            }
//        }
//    }
}
