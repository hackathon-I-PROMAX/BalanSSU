//
//  MainCategoriesService.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/25.
//

import Foundation
import Moya

final class MainCategoriesService {
    
    private var mainCategoriesProvider = MoyaProvider<MainCategoriesAPI>()
    
    private enum ResponseData {
        case getMainCategories
    }
    
    public func getMainCategories(completion: @escaping (NetworkResult<Any>) -> Void) {
        mainCategoriesProvider.request(.getMainCategories) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getMainCategories)
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
            case .getMainCategories:
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
        case .getMainCategories:
            guard let decodedData = try? decoder.decode(MainCategoriesResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
