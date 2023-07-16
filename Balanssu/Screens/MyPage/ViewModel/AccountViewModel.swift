//
//  AccountViewModel.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/07.
//

import Foundation

import RxSwift
import RxCocoa

final class AccountViewModel: ViewModelType {
    
    private let myPageDataSource: DefaultMyPageDataSource
    var disposeBag = DisposeBag()
    
    init(myPageDataSource: DefaultMyPageDataSource) {
        self.myPageDataSource = myPageDataSource
    }
    
    struct Input {
        let didWithDrawTextFieldChange: Observable<String>
        let tapConfirmButton: Observable<Void>
    }
    
    struct Output {
        let isWithDrawValid = PublishRelay<Bool>()
        let alert = PublishRelay<ErrorAlertType>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.didWithDrawTextFieldChange
            .distinctUntilChanged()
            .withUnretained(self)
            .map { owner, text in
                owner.withDrawValidCheck(text: text)
            }
            .subscribe(onNext: { result in
                output.isWithDrawValid.accept(result)
            })
            .disposed(by: disposeBag)
        
        input.tapConfirmButton
            .withLatestFrom(output.isWithDrawValid)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                if result {
                    owner.withDraw()
                    output.alert.accept(.withDrawSuccess)
                } else {
                    output.alert.accept(.withDrawError)
                }
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    func resetUserDefaultValues() {
        UserDefaultHandler.accessToken = ""
        UserDefaultHandler.refreshToken = ""
        UserDefaultHandler.loginStatus = false
    }
    
    private func withDrawValidCheck(text: String) -> Bool {
        return text == "밸런슈 그동안 고마웠어요"
    }
    
    private func withDraw() {
        myPageDataSource.deleteUser()
            .subscribe { [weak self] result in
                switch result {
                case .success(_):
                    self?.resetUserDefaultValues()
                case .failure(_):
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}
