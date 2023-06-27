//
//  MyPageService.swift
//  Balanssu
//
//  Created by 이조은 on 2023/05/26.
//

import Foundation
import Moya

final class MyPageService {
    
    private var myPageProvider = MoyaProvider<MyPageAPI>()
    
    private enum ResponseData {
        case myPage
    }
    
    public func getMyPage(completion: @escaping (NetworkResult<Any>) -> Void) {
        myPageProvider.request(.getMyPageAPI) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .myPage)
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
            case .myPage:
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
        case .myPage:
            guard let decodedData = try? decoder.decode(MyPageResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
    
}
