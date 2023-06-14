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
    
    struct Input {
        let didIdTextFieldChange: Observable<String>
        let didPasswordTextFieldChange: Observable<String>
        let didPasswordCheckTextFieldChange: Observable<String>
        let didPasswordTextFieldDidTapEvent: Observable<Void>
        let tapConfirmButton: Observable<Void>
//        let tapBackButton: Signal<Void>
    }
    
    struct Output { 
//        let didBackButtonTapped: Signal<Void>
//        let didConfirmButtonTapped: Signal<Void>
        let isIdValid = PublishRelay<Bool>()
        let isPasswordValid = PublishRelay<Bool>()
        let isPasswordCheckValid = PublishRelay<Bool>()
        let isAllInputValid = PublishRelay<Bool>()
    }
    
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        let isAllInputValid = Observable.combineLatest(output.isIdValid, output.isPasswordValid, output.isPasswordCheckValid, resultSelector: { $0 && $1 && $2 })
        
        input.didIdTextFieldChange
            .distinctUntilChanged()
            .withUnretained(self)
            .map { owner, text in
                owner.validate(text: text)
            }
            .subscribe(onNext: { result in
                output.isIdValid.accept(result)
            })
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
        
        return output
    }
    
    private func validate(text: String) -> Bool {
        return text.count > 8
    }
    
    private func passwordValidCheck(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@#$%^&+=]).{8,20}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}
