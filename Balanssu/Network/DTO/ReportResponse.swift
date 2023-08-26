//
//  ReportResponse.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/08/26.
//

import Foundation

struct ReportResponse: Codable {
    let reports: Reports
}

// MARK: - Comments
struct Reports: Codable {
    let content: String
    let email: String
    let type: String
}
