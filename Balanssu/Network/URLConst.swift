//
//  URLConst.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/19.
//

enum URLConst {
    // MARK: - baseURL
    static let base = "https://balanssu-api.yourssu.com"
    
    static let createQuestion = "https://docs.google.com/forms/d/e/1FAIpQLScUWg9XFi7fnVLgcJux0kTPLB1yzBjzIUU_BdR19XzGjyccMQ/viewform"
    
    static let useTermsURL = "https://balanssu.notion.site/e097e709922e4fae9c5b363c2bb6e3c4?pvs=4"
    
    static let TermsURL = "https://balanssu.notion.site/204fde7ba05945feb42625bcdb0de93f?pvs=4"
    
    static let openSourceURL = "https://balanssu.notion.site/72f64bb1cff047a394ffb2e9975642a9"
    
    // MARK: - signIn
    static let signIn = "/auth/sign-in"
    
    // MARK: - signUp
    static let signUp = "/auth/sign-up"
    
    // MARK: - validationId
    static let validationId = "/auth/validation/username"
    
    // MARK: - main
    static let main = "/categories/main"
    
    // MARK: - Category
    static let voteList = "/categories"
    
    // MARK: - VoteView
    static let voteView = "/categories"
    static let comment = "/comments"
    static let report = "/categories"

    // MARK: - Choices
    static let choices = "/choices"
    
    // MARK: - token
    static let refresh = "/auth/refresh"
    
    // MARK: - Mypage
    static let myPage = "/auth/info"
    
    // MARK: - Withdrawal
    static let withdrawal = "/auth/withdrawal"
    
}

