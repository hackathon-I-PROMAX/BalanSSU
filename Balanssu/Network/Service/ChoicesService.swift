//
//  ChoicesService.swift
//  Balanssu
//
//  Created by 김규철 on 2023/03/20.
//

import Foundation
import Moya

final class ChoicesService {

//    private var choicesProvider = MoyaProvider<ChoicesAPI>()
    private var choicesProvider = MoyaProvider<ChoicesAPI>(session: Moya.Session(interceptor: Interceptor()), plugins: [MoyaLoggerPlugin()])

    private enum ResponseData {
        case postChoices
    }

    public func postChoices(categoryId: String, choiceId: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        choicesProvider.request(.postChoice(categoryId: categoryId, choiceId: choiceId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postChoices)
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
            case .postChoices:
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
        case .postChoices:
            guard let decodedData = try? decoder.decode(ChoicesResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
