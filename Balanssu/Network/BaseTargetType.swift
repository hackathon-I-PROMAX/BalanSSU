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
    
    var headers: [String : String]? {
        
            var headers: [String: String]? {
                if let token = UserDefaults.standard.value(forKey: UserDefaultKey.accessToken) {
                    let header = [
                        "Content-Type": "application/json",
                        "Authorization": "Bearer \(String(describing: token))"
                    ]
                    return header
                } else {
                    let header = [
                        "Content-Type": "application/json"
                    ]
                    return header
                }
            }
    }
}

