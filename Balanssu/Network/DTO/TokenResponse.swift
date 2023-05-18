//
//  TokenResponse.swift
//  Balanssu
//
//  Created by 김규철 on 2023/05/18.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let accessTokenExpiresIn: Int
    let refreshToken: String
    let refreshTokenExpiresIn: Int
}
