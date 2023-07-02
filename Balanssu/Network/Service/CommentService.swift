//
//  CommentService.swift
//  Balanssu
//
//  Created by 이조은 on 2023/06/24.
//

import Foundation
import Moya

final class CommentService {

    private var commentProvider = MoyaProvider<CommentAPI>()

    private enum ResponseData {
        case getComment
    }

    public func getComment(categoryId: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        commentProvider.request(.getComment(categoryId: categoryId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getComment)
                completion(networkResult)
                
            case .failure(let error):
                print("123 \(error)")
                
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {

        let decoder = JSONDecoder()

        switch statusCode {
        case 200..<300:
            switch responseData {
            case .getComment:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            print(statusCode)
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                return .pathErr
            }
            print(decodedData)
            return .requestErr(data)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch responseData {
        case .getComment:
            guard let decodedData = try? decoder.decode(CommentResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}


