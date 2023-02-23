//
//  AuthAPI.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/20.
//

import Foundation
import Moya

enum AuthAPI {
    case postSignIn(password: String, username: String)
    case postSignUp(username: String, password: String, nickname: String, schoolAge: String, departure: String, gender: String)
}

extension AuthAPI: BaseTargetType {
    var path: String {
        switch self {
        case .postSignUp:
            return URLConst.signUp
        case .postSignIn:
            return URLConst.signIn
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignIn,.postSignUp:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postSignIn(let password, let username):
            return .requestParameters(parameters: [
                                        "password": password,
                                        "username": username
            ], encoding: JSONEncoding.default)
        case .postSignUp(let username, let password, let nickname, let schoolAge, let departure, let gender):
            return .requestParameters(parameters: [
                "username": username,
                "password": password,
                "nickname": nickname,
                "schoolAge": schoolAge,
                "departure": departure,
                "gender": gender
            ], encoding: JSONEncoding.default)
        }
    }
}
