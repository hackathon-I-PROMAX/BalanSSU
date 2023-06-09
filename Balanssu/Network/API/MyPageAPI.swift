//
//  MyPageAPI.swift
//  Balanssu
//
//  Created by 이조은 on 2023/05/25.
//
import Foundation
import Moya

enum MyPageAPI {
    case getMyPageAPI
}

extension MyPageAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getMyPageAPI:
            return URLConst.myPage
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageAPI:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageAPI:
            return .requestPlain
        }
    }
}
