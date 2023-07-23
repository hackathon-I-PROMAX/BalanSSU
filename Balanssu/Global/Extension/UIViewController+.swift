//
//  UIViewController+.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/07.
//

import UIKit

extension UIViewController {
    func presentAlert(type: AlertType,
                      leftButtonAction: ButtonAction? = nil,
                      rightButtonAction: ButtonAction? = nil) {
        let alertPresenter = BalanSSUPopup(alertType: type)
        alertPresenter.present(on: self,
                               alertType: type,
                               leftButtonAction: leftButtonAction,
                               rightButtonAction: rightButtonAction)
    }
    
    func errorPresentAlert(type: ErrorAlertType,
                           buttonAction: ButtonAction? = nil) {
        let alertPresenter = BalanSSUErrorPopup(alertType: type)
        alertPresenter.errorPresent(on: self, alertType: type, buttonAction: buttonAction)
    }
}
