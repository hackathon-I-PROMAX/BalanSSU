//
//  AuthService.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/20.
//

import Foundation
import Moya

final class AuthService {
    
    private var authProvider = MoyaProvider<AuthAPI>()
    
    public func postSignUp(username: String, password: String, nickname: String, schoolAge: String, departure: String, gender: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignUp(username: username, password: password, nickname: nickname, schoolAge: schoolAge, departure: departure, gender: gender)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

        let decoder = JSONDecoder()

        switch statusCode {
        case 201:
//            guard let decodedData = try? decoder.decode(BlankDataResponse.self, from: data) else {
//                return .pathErr
//            }
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
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
    
}

