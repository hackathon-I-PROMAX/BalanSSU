//
//  RxViewController.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/07.
//

import UIKit

import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
      let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
      return ControlEvent(events: source)
    }

    var viewWillAppear: ControlEvent<Bool> {
      let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
      return ControlEvent(events: source)
    }
    var viewDidAppear: ControlEvent<Bool> {
      let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
      return ControlEvent(events: source)
    }

    var viewWillDisappear: ControlEvent<Bool> {
      let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
      return ControlEvent(events: source)
    }
    var viewDidDisappear: ControlEvent<Bool> {
      let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
      return ControlEvent(events: source)
    }
}

