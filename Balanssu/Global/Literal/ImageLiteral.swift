//
//  ImageLiteral.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

enum ImageLiterals {
    static var navigationBarBackButton: UIImage { .load(name: "backButton") }
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
}
    
