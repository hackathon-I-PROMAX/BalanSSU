//
//  VoteViewAPI.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/25.
//

import Foundation
import Moya

enum VoteViewAPI {
    case getVoteViewAPI(categoryId: String)
}

extension VoteViewAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getVoteViewAPI(let categoryId):
            return URLConst.voteView + "/\(categoryId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getVoteViewAPI:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getVoteViewAPI:
            return .requestPlain
        }
    }
}
