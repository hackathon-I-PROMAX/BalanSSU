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
    case postRefreshToken(refreshToken: String)
}

extension AuthAPI: BaseTargetType {
    var headers: [String: String]? {
        switch self {
        case .postSignIn, .postSignUp, .postRefreshToken:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .postSignUp:
            return URLConst.signUp
        case .postSignIn:
            return URLConst.signIn
        case .postRefreshToken:
            return URLConst.refresh
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignIn,.postSignUp, .postRefreshToken:
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
        case .postRefreshToken(let refreshToken):
            return .requestParameters(parameters: [
                "refreshToken": refreshToken
            ], encoding: JSONEncoding.default)
        }
    }
}

