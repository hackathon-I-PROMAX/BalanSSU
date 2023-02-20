//
//  AuthService.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/20.
//

import Foundation
import Moya

final class AuthService {
    
    static let shared = AuthService()
    private var AuthProvider = MoyaProvider<AuthAPI>()
    
    func postSignup()
    
}

