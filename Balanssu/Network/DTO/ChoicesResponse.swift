//
//  ChoicesResponse.swift
//  Balanssu
//
//  Created by 김규철 on 2023/05/15.
//

import Foundation

// MARK: - Choices
struct ChoicesResponse: Codable {
    let category: Category
    let choices: [Choice]
}

// MARK: - Category
struct Category: Codable {
    let categoryID: String
    let dday: Int
    let isParticipating: Bool
    let myChoice: String
    let participantCount: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case dday, isParticipating, myChoice, participantCount, title
    }
}

// MARK: - Choice
struct Choice: Codable {
    let choiceID: String
    let count: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case choiceID = "choiceId"
        case count, name
    }
}
