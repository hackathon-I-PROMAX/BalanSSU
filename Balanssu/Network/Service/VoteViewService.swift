//
//  VoteViewService.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/25.
//

import Foundation
import Moya

final class VoteViewService {
    
    private var voteViewProvider = MoyaProvider<VoteViewAPI>()
//    private var voteViewProvider = MoyaProvider<VoteViewAPI>(session : Moya.Session(interceptor: Interceptor()))
    
    private enum ResponseData {
        case voteView
    }
    
    public func getVoteView(categoryId: String,completion: @escaping (NetworkResult<Any>) -> Void) {
        voteViewProvider.request(.getVoteViewAPI(categoryId: categoryId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .voteView)
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
            case .voteView:
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
        print("=====data: \(data)")
        
        switch responseData {
        case .voteView:
            guard let decodedData = try? decoder.decode(VoteViewResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
    
}
