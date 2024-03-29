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
    case postSignUp(username: String, password: String, nickname: String, schoolAge: String, mbti: String, gender: String)
    case postRefreshToken(refreshToken: String)
    case postValidationId(username: String)
}

extension AuthAPI: BaseTargetType {
    var headers: [String: String]? {
        switch self {
        case .postSignIn, .postSignUp, .postRefreshToken, .postValidationId:
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
        case .postValidationId:
            return URLConst.validationId
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignIn,.postSignUp, .postRefreshToken, .postValidationId:
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
        case .postSignUp(let username, let password, let nickname, let schoolAge, let mbti, let gender):
            return .requestParameters(parameters: [
                "username": username,
                "password": password,
                "nickname": nickname,
                "schoolAge": schoolAge,
                "mbti": mbti,
                "gender": gender
            ], encoding: JSONEncoding.default)
        case .postRefreshToken(let refreshToken):
            return .requestParameters(parameters: [
                "refreshToken": refreshToken
            ], encoding: JSONEncoding.default)
        case .postValidationId(let username):
            return .requestParameters(parameters: [
                "username": username
            ], encoding: JSONEncoding.default)
        }
    }
}

