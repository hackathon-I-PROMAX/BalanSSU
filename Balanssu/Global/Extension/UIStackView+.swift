//
//  UIStackView+.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/08.
//

import Foundation

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for v in views {
            self.addArrangedSubview(v)
        }
    }
}
