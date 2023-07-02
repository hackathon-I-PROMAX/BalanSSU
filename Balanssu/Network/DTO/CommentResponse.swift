//
//  CommentResponse.swift
//  Balanssu
//
//  Created by 이조은 on 2023/06/24.
//

import Foundation

// MARK: - CommentResponse
struct CommentResponse: Codable {
    let comments: Comments
}

// MARK: - Comments
struct Comments: Codable {
    let content: [Content]
    let pageable: Pageable
    let empty, first, last: Bool
    let number, numberOfElements: Int
    let size: Int
    let sort: Sort
    let totalElements, totalPages: Int
}

// MARK: - Content
struct Content: Codable {
    let commentID, content, department, nickname: String
    let isOwner, isUserDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case content, department, isOwner, isUserDeleted, nickname
    }
}

// MARK: - Pageable
struct Pageable: Codable {
    let offset, pageNumber, pageSize: Int
    let paged: Bool
    let sort: Sort
    let unpaged: Bool
}

// MARK: - Sort
struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
