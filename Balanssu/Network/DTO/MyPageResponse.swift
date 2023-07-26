//
//  MyPageResponse.swift
//  Balanssu
//
//  Created by 이조은 on 2023/05/25.
//
import UIKit

struct MyPageResponse: Codable {
    let user: myPageData
}

struct myPageData: Codable {
    let mbti: String
    let nickname: String
    let schoolAge: String
    let username: String
}
