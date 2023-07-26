//
//  AlertType.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/12.
//

import Foundation

enum AlertType {
    case logout
    case withDraw

    var title: String {
      switch self {
      case .logout: return "로그아웃"
      case .withDraw: return "회원탈퇴"
      }
    }

    var description: String {
      switch self {
      case .logout: return "밸런슈에서 나가시겠어요?"
      case .withDraw: return "밸런슈 계정을 탈퇴하시겠어요?"
      }
    }

    var leftButtonTitle: String {
      switch self {
      case .logout, .withDraw:
        return "다음에요"
      }
    }

    var rightButtonTitle: String {
      switch self {
      case .logout:
        return "나갈래요"
      case .withDraw:
        return "탈퇴하기"
      }
    }
  }
