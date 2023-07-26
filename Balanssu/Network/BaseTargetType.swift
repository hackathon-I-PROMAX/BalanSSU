//
//  BaseTargetType.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/19.
//

import Foundation

import Moya

protocol BaseTargetType:TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: URLConst.base)!
    }
    
    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        let header = [
            "Content-Type": "application/json",
            "Authorization": UserDefaultHandler.accessToken
        ]
        return header
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

