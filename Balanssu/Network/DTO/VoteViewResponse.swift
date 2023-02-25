//
//  VoteViewResponse.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/25.
//

import UIKit

struct VoteViewResponse: Codable {
    let category: categoryData
    let choices: [choicesData]
    let comments: [commentsData]
}

struct categoryData: Codable {
    let categoryId: String
    let dday: Int
    let isParticipating: Bool
    let myChoice: String?
    let participantCount: Int
    let title: String
}

struct choicesData: Codable {
    let choiceId: String
    let count: Int
    let name: String
}

struct commentsData: Codable {
    let content: String
    let department: String
    let isOwner: Bool
    let nickname: String
}

