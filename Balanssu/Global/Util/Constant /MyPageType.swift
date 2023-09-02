//
//  MyPageType.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/06.
//

import Foundation

enum MyPageType: CaseIterable, CustomStringConvertible {
    case appInfo
    case account
    
    var contents: [String] {
        switch self {
        case .appInfo:
            return ["밸런슈가 궁금해요", "만든 사람들", "서비스 이용약관", "오픈소스 사용정보", "서비스 이용규칙"]
        case .account:
            return ["비밀번호 변경", "계정 관리"]
        }
    }
    
    var numberOfRowInSections: Int {
        return contents.count
    }
    
    var description: String {
        switch self {
        case .appInfo:
            return "앱 정보"
        case .account:
            return "계정"
        }
    }
}

enum AccountType: String, CaseIterable {
    case logout = "로그아웃"
    case withdrawal = "계정 탈퇴"
}
    
