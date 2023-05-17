//
//  Interceptor.swift
//  Balanssu
//
//  Created by 김규철 on 2023/05/18.
//

import Foundation

import Alamofire
import Moya

final class Interceptor: RequestInterceptor {
    
    private let limit = 2
    private let retryDelay: TimeInterval = 1
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: UserDefaultHandler.accessToken))
        
        print("adapt 적용 \(urlRequest.headers)")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        let statusCode = response.statusCode
        guard request.retryCount < limit, statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        getToken { isSuccess in
            if isSuccess {
                if request.retryCount < self.limit {
                    completion(.retryWithDelay(self.retryDelay))
                }
            } else {
                print("refresh token expired")
                completion(.doNotRetry)
            }
        }
    }
    
    private func getToken(completion: @escaping(Bool) -> Void) {
        NetworkService.shared.auth.postRereshToken(rereshToken: UserDefaultHandler.refreshToken) { result in
            switch result {
            case .success(let response):
                guard let data = response as? TokenResponse else { return }
                UserDefaultHandler.accessToken = data.accessToken
                UserDefaultHandler.refreshToken = data.refreshToken
                completion(true)
            case .requestErr(let error):
                dump(error)
            default:
                print("error")
                
            }
        }
    }
}
