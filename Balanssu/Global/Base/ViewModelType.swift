//
//  ViewModelType.swift
//  Balanssu
//
//  Created by 김규철 on 2023/06/10.
//

import Foundation

import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    var disposeBag: DisposeBag { get set }

    func transform(input: Input) -> Output
}
