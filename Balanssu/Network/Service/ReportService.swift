//
//  ReportService.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/08/26.
//

import Foundation
import Moya

final class ReportService {

    private var reportProvider = MoyaProvider<ReportAPI>()

    private enum ResponseData {
        case postReport
        case getReport
    }

    public func postReport(categoryId: String, commentId: String, content: String, email: String, type: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        reportProvider.request(.postReport(categoryId: categoryId, commentId: commentId, content: content, email: email, type: type)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postReport)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

    public func getReport(categoryId: String, commentId: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        reportProvider.request(.getReport(categoryId: categoryId, commentId: commentId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getReport)
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
            case .postReport, .getReport:
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
        case .postReport:
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
        case .getReport:
            guard let decodedData = try? decoder.decode(ReportAvailableResponse.self, from: data) else {
                return .networkFail
            }
            return .success(decodedData)
        }
    }
}
