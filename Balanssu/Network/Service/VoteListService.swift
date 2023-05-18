//
//  VoteListService.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/25.
//

import Foundation
import Moya

final class VoteListService {
    
    private var voteListProvider = MoyaProvider<VoteListAPI>(session : Moya.Session(interceptor: Interceptor()))
    
    private enum ResponseData {
        case voteList
    }
    
    public func getVoteList(completion: @escaping (NetworkResult<Any>) -> Void) {
        voteListProvider.request(.getVoteListAPI) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .voteList)
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
            case .voteList:
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
        case .voteList:
            guard let decodedData = try? decoder.decode(VoteListResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
    
}
