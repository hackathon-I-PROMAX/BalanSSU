//
//  RootHandler.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/16.
//

import UIKit

final class RootHandler {
    static let shard = RootHandler()
    
     func presentStartVC() {
         guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
         let rootVC = StartViewController()
                     // MARK: - 로그인 뷰로 이동
                     sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: rootVC)
         rootVC.navigationController?.setViewControllers([rootVC], animated: true)
    }
}
