//
//  Coordinator.swift
//  Balanssu
//
//  Created by 김규철 on 2023/06/16.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    
}
