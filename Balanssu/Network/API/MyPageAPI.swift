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
    case deleteUser
}

extension MyPageAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getMyPageAPI:
            return URLConst.myPage
        case .deleteUser:
            return URLConst.withdrawal
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageAPI:
            return .get
        case .deleteUser:
            return .delete
        }
        
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageAPI, .deleteUser:
            return .requestPlain
        }
    }
}
