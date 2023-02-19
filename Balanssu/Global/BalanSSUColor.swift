//
//  BalanSSUColor.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/19.
//

import Foundation
import UIKit

enum CustomColor {
    case defaultBlue
    case defaultGray
}

extension UIColor {
    
    static func customColor(_ color: CustomColor) -> UIColor {
        switch color {
        case .defaultBlue:
            return UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1.00)
        case .defaultGray:
            return UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1.00)
        }
    }
}
