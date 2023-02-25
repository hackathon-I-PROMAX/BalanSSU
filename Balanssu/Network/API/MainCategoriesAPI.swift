//
//  MainCategoriesAPI.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/25.
//

import Foundation
import Moya

enum MainCategoriesAPI {
    case getMainCategories
}

extension MainCategoriesAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getMainCategories:
            return URLConst.main
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMainCategories:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMainCategories:
            return .requestPlain
        }
    }
}

