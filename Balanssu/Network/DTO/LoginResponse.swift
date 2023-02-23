//
//  LoginResponse.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/23.
//

import Foundation

struct LoginResponse: Codable {
    
    let accessToken: String
    var accessTokenExpiresIn: Int = 0
    let refreshToken: String
    var refreshTokenExpiresIn: Int = 0
    
}
