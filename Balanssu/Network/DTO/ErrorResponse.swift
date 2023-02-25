//
//  ErrorResponse.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/21.
//

import Foundation

struct ErrorResponse: Codable {
    
    let timeStamp: String?
    let status: Int?
    let error: String?
    let message: String?
    
}
