//
//  AuthDataSource.swift
//  Balanssu
//
//  Created by 김규철 on 2023/06/22.
//

import Moya
import RxMoya
import RxSwift

protocol AuthDataSource {
    func postValidationId(userName: String) -> Single<Result<BlankDataResponse, NetworkError>>
}

final class DefaultAuthDataSource: AuthDataSource {
    
   private let moyaProvider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])

    
    func postValidationId(userName: String) -> Single<Result<BlankDataResponse, NetworkError>> {
        return moyaProvider.rx.request(.postValidationId(username: userName))
            .flatMap { NetworkHandler.requestNoResult(by: $0) }
    }
}


// map을 쓰면 Generic parameter 'T' could not be inferred가 뜨는 이유
// map 연산자에 전달된 클로저의 반환 타입이 명시되지 않아 컴파일러가 타입을 유추할 수 없기 때문
// .map(BlankDataResponse.self)
