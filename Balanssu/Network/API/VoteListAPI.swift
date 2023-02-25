//
//  VoteListAPI.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/25.
//

import Foundation
import Moya

enum VoteListAPI {
    case getVoteListAPI
}

extension VoteListAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getVoteListAPI:
            return URLConst.voteList
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getVoteListAPI:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getVoteListAPI: 
            return .requestPlain
        }
    }
}
