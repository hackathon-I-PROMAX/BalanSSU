//
//  CommentAPI.swift
//  Balanssu
//
//  Created by 이조은 on 2023/06/24.
//

import Foundation
import Moya

enum CommentAPI {
    case getComment(categoryId: String)
}

extension CommentAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getComment:
            return URLConst.comment
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getComment:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getComment(let categoryId):
            return .requestParameters(parameters: [
                "categoryId": categoryId 
            ], encoding: URLEncoding.default)
        }
    }
}
