//
//  ReportAPI.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/08/26.
//

import Foundation
import Moya

enum ReportAPI {
    case postReport(categoryId: String, commentId: String, content: String, email: String, type: String)
    case getReport(categoryId: String, commentId: String)
}

extension ReportAPI: BaseTargetType {
    var path: String {
        switch self {
        case let .postReport(categoryId, commentId, _, _, _):
            return URLConst.report + "/\(categoryId)/comments/\(commentId)/reports"
        case let .getReport(categoryId, commentId):
            return URLConst.report + "/\(categoryId)/comments/\(commentId)/reports/available"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReport:
            return .post
        case .getReport:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postReport(_, _, content, email, type):
            return .requestParameters(parameters: [
                "content": content,
                "email": email,
                "type": type
            ], encoding: JSONEncoding.default)
        case .getReport:
            return .requestPlain
        }
    }
}
