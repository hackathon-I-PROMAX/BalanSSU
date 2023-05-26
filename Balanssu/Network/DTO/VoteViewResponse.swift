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

