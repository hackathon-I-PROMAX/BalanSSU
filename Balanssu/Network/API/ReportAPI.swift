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
}

extension ReportAPI: BaseTargetType {
    var path: String {
        switch self {
        case let .postReport(categoryId, commentId, _, _, _):
            return "/categories/\(categoryId)/comments/\(commentId)/reports"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReport:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postReport(_, _, let content, let email, let type):
            return .requestParameters(parameters: [
                "content": content,
                "email": email,
                "type": type
            ], encoding: JSONEncoding.default)
        }
    }
}
