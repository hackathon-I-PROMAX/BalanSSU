//
//  NetworkHandler.swift
//  Balanssu
//
//  Created by 김규철 on 2023/06/24.
//

import Foundation

import Moya
import RxSwift

final class NetworkHandler {
    public static func requestDecoded<T: Decodable>(by response: Response) -> Single<Result<T, NetworkError>> {
        let decoder = JSONDecoder()
        
        switch response.statusCode {
        case 200..<300:
            guard let decodedData = try? decoder.decode(T.self, from: response.data) else {
                return .just(.failure(.decodedErr))
            }
            return .just(.success(decodedData))
        case 300..<500:
            guard let errorResponse = try? decoder.decode(ErrorResponse.self, from: response.data) else {
                return .just(.failure(.pathErr))
            }
            return .just(.failure(.requestErr(errorResponse)))
        default:
            return .just(.failure(.networkFail))
        }
    }
    
    public static func requestNoResult(by response: Response) -> Single<Result<BlankDataResponse, NetworkError>> {
        let decoder = JSONDecoder()

        switch response.statusCode {
        case 200..<300:
            return .just(.success(BlankDataResponse()))
        case 300..<500:
            guard let errorResponse = try? decoder.decode(ErrorResponse.self, from: response.data) else {
                return .just(.failure(.pathErr))
            }
            return .just(.failure(.requestErr(errorResponse)))
        default:
            return .just(.failure(.networkFail))
        }
    }
}
