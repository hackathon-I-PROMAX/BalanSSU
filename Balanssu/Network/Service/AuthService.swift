//
//  AuthService.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/20.
//

import Foundation
import Moya

final class AuthService {
    
    private var tokenProvider = MoyaProvider<AuthAPI>(session: Moya.Session(interceptor: Interceptor()), plugins: [MoyaLoggerPlugin()])
    private var authProvider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case postSignUp
        case postSignIn
        case postRereshToken
    }
    
    public func postSignUp(username: String, password: String, nickname: String, schoolAge: String, departure: String, gender: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignUp(username: username, password: password, nickname: nickname, schoolAge: schoolAge, departure: departure, gender: gender)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postSignUp)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    public func postSignIn(password: String, username: String, completion: @escaping (NetworkResult<Any>) -> Void ) {
        authProvider.request(.postSignIn(password: password, username: username)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postSignIn)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func postRereshToken(refreshToken: String, completion: @escaping (NetworkResult<Any>) -> Void ) {
        tokenProvider.request(.postRefreshToken(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postRereshToken)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {

        let decoder = JSONDecoder()

        switch statusCode {
        case 200..<300:
            switch responseData {
            case .postSignIn, .postSignUp, .postRereshToken:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch responseData {
        case .postSignIn:
            guard let decodedData = try? decoder.decode(LoginResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postSignUp:
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
        case .postRereshToken:
            guard let decodedData = try? decoder.decode(TokenResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
    
}


