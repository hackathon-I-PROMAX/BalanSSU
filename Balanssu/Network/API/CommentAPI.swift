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
    case postComment(categoryId: String, content: String)
}

extension CommentAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getComment, .postComment:
            return URLConst.comment
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getComment:
            return .get
        case .postComment:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getComment(let categoryId):
            return .requestParameters(parameters: [
                "categoryId": categoryId 
            ], encoding: URLEncoding.default)
        case .postComment(let categoryId, let content):
            return .requestParameters(parameters: [
                "categoryId": categoryId,
                "content": content
            ], encoding: JSONEncoding.default)
        }
    }
}
