//
//  SetAuthViewModel.swift
//  Balanssu
//
//  Created by 김규철 on 2023/06/10.
//

import Foundation

import RxSwift
import RxCocoa

class SetAuthViewModel:ViewModelType {

    var disposeBag = DisposeBag()
    private let authDataSource: DefaultAuthDataSource
    var booll = Bool()

    init(authDataSource: DefaultAuthDataSource) {
        self.authDataSource = authDataSource
    }
    
    struct Input {
        let didIdTextFieldChange: Observable<String>
        let didPasswordTextFieldChange: Observable<String>
        let didPasswordCheckTextFieldChange: Observable<String>
        let didPasswordTextFieldDidTapEvent: Observable<Void>
        let didIdValidationEvent: Observable<Void>
        let tapConfirmButton: Observable<Void>
//        let tapBackButton: Signal<Void>
    }
    
    struct Output { 
//        let didBackButtonTapped: Signal<Void>
        let isIdValid = PublishRelay<Bool>()
        let id = BehaviorRelay<String>(value: "")
        let didIdDuplicateCheck = PublishRelay<Bool>()
        let isPasswordValid = PublishRelay<Bool>()
        let isPasswordCheckValid = PublishRelay<Bool>()
        let isAllInputValid = PublishRelay<Bool>()
        let didConfirmButtonTapped = PublishRelay<(String, String)>()
        let validationErrorMessage = BehaviorRelay<String>(value: "")
    }
    
    
    func transform(input: Input) -> Output {
        let output = Output()

        let isAllInputValid = Observable.combineLatest(output.isIdValid, output.isPasswordValid, output.isPasswordCheckValid, output.didIdDuplicateCheck, resultSelector: { $0 && $1 && $2 && $3 })
        
        input.didIdTextFieldChange
            .distinctUntilChanged()
            .withUnretained(self)
            .map { owner, text in
                owner.idValidCheck(id: text)
            }
            .subscribe(onNext: { result in
                output.isIdValid.accept(result)
            })
            .disposed(by: disposeBag)
        
        input.didIdTextFieldChange
            .subscribe(onNext: { text in
                output.id.accept(text)
            })
            .disposed(by: disposeBag)
        
        input.didIdValidationEvent
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.checkIdValid(userName: output.id.value)
            }
            .bind(to: output.didIdDuplicateCheck)
            .disposed(by: disposeBag)
    
        input.didPasswordTextFieldChange
            .distinctUntilChanged()
            .withUnretained(self)
            .map { owner, text in
                owner.passwordValidCheck(password: text)
            }
            .debug()
            .subscribe(onNext: { result in
                output.isPasswordValid.accept(result)
            })
            .disposed(by: disposeBag)
        
        input.didPasswordTextFieldDidTapEvent
            .withLatestFrom(Observable.combineLatest(input.didPasswordTextFieldChange, input.didPasswordCheckTextFieldChange))
            .map { password, checkPassword in
                !checkPassword.isEmpty && password == checkPassword
            }
            .debug()
            .subscribe(onNext: { result in
                output.isPasswordCheckValid.accept(result)
            })
            .disposed(by: disposeBag)
        
        isAllInputValid
            .subscribe(onNext: { match in
                output.isAllInputValid.accept(match)
            })
            .disposed(by: disposeBag)
        
        input.tapConfirmButton
            .withLatestFrom(isAllInputValid)
            .filter { $0 }
            .withLatestFrom(Observable.combineLatest(input.didIdTextFieldChange, input.didPasswordTextFieldChange))
            .subscribe(onNext: { id, passwd in
                output.didConfirmButtonTapped.accept((id, passwd))
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func idValidCheck(id: String) -> Bool {
        let idRegex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$"
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", idRegex)
        return idPredicate.evaluate(with: id)
    }
    
    private func passwordValidCheck(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@#$%^&+=]).{8,20}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    private func checkIdValid(userName: String) -> Single<Bool> {
        let output = Output()
        return authDataSource.postValidationId(userName: userName)
            .map { result -> Bool in
                switch result {
                case .success:
                    return true
                case .failure(let error):
                    switch error {
                    case .requestErr(let err):
                        output.validationErrorMessage.accept(err.message ?? "")
                    default:
                        print(error)
                    }
                    return false
                }
            }
            .catchAndReturn(false)
    }
}



