//
//  URLConst.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/19.
//

enum URLConst {
    // MARK: - baseURL
    static let base = "https://balanssu-api.yourssu.com"

    // MARK: - Auth
    // 로그인
    static let signIn = "/auth/sign-in"
    
    // 회원가입
    static let signUp = "/auth/sign-up"
    
    // 메인
    static let main = "/categories/main"
    
    // MARK: - Category
    static let voteList = "/categories"
    
    // MARK: - VoteView
    static let voteView = "/categories"
    
    // MARK: - Choices
    static let choices = "/choices"
    
    // MARK: - token
    static let refresh = "/auth/refresh"
}
