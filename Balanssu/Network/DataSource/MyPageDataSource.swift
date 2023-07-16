//
//  MyPageDataSource.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/07.
//

import Foundation

import RxSwift
import Moya

protocol MyPageDataSource {
    func getUserInfo() -> Single<Result<MyPageResponse, NetworkError>>
    func deleteUser() -> Single<Result<BlankDataResponse, NetworkError>>
}

final class DefaultMyPageDataSource: MyPageDataSource {
    
   private let moyaProvider = MoyaProvider<MyPageAPI>(plugins: [MoyaLoggerPlugin()])

    func getUserInfo() -> Single<Result<MyPageResponse, NetworkError>> {
        return moyaProvider.rx.request(.getMyPageAPI)
            .flatMap { NetworkHandler.requestDecoded(by: $0) }
    }
    
    func deleteUser() -> Single<Result<BlankDataResponse, NetworkError>> {
        return moyaProvider.rx.request(.deleteUser)
            .flatMap { NetworkHandler.requestNoResult(by: $0) }
    }
}
