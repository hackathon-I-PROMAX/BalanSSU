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
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IkpvZXVuMTIzNCIsInJvbGVzIjpbIlJPTEVfVVNFUiJdfQ.BPJ92tnJZN2nHfvrXK33gVtPbnAz6tlA9cPN_8Nx1Y0"
        ]
        return header
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}


