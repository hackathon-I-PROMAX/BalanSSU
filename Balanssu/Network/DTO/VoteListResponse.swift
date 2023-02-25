//
//  VoteListResponse.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/25.
//

import UIKit

struct VoteListResponse: Codable {
    let categories: [voteListData]
}

struct voteListData: Codable {
    let categoryId: String
    let dday: Int
    let participantCount: Int
    let title: String
    let type: String
}
