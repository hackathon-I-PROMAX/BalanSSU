//
//  ErrorAlertType.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/15.
//

import Foundation

enum ErrorAlertType {
    case withDrawError
    case withDrawSuccess
    case changePasswordError
    case idDuplicateError

    var title: String {
      switch self {
      case .withDrawError: return "문장을 온전히 입력해주세요"
      case .withDrawSuccess: return "탈퇴가 완료되었어요"
      case .changePasswordError: return "준비 중입니다"
      case .idDuplicateError: return "이미 사용 중인 아이디 입니다."
      }
    }

    var description: String {
      switch self {
      case .withDrawError: return "문장을 제대로 입력해야 탈퇴가 완료돼요."
      case .withDrawSuccess: return "그동안 밸런슈를 이용해주셔서 감사했어요."
      case .changePasswordError: return "업데이트 후 기능 제공 예정입니다."
      case .idDuplicateError: return "다른 영/숫자 포함 8자리 아이디를 입력해주세요."
      }
    }

    var buttonTitle: String {
      switch self {
      case .withDrawError, .withDrawSuccess, .changePasswordError, .idDuplicateError:
        return "확인"
      }
    }
}
