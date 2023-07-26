//
//  NetworkError.swift
//  Balanssu
//
//  Created by 김규철 on 2023/06/24.
//

import Foundation

enum NetworkError: Error {
    case requestErr(ErrorResponse)
    case decodedErr
    case pathErr
    case networkFail
}
