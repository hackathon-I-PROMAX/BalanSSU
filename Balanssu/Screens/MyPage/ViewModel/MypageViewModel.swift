//
//  MypageViewModel.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/06.
//

import Foundation

import RxSwift
import RxCocoa

final class MypageViewModel: ViewModelType {
    
    private let myPageDataSource: DefaultMyPageDataSource
    var disposeBag = DisposeBag()
    
    
    init(myPageDataSource: DefaultMyPageDataSource) {
        self.myPageDataSource = myPageDataSource
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let authInfo = PublishRelay<MyPageResponse>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewWillAppear
            .withUnretained(self)
            .flatMapLatest { owner, _ -> Single<Result<MyPageResponse, NetworkError>> in
                return owner.myPageDataSource.getUserInfo()
            }
            .subscribe(onNext: { result in
                switch result {
                case .success(let response):
                    output.authInfo.accept(response)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
        return output
    }
}

