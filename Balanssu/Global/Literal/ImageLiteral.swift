//
//  ImageLiteral.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

enum ImageLiterals {
    static var navigationBarBackButton: UIImage { .load(name: "backButton") }
    static var hotCellOne: UIImage { .load(name: "hotCell1") }
    static var hotCellTwo: UIImage { .load(name: "hotCell2") }
    static var hotCellThree: UIImage { .load(name: "hotCell3") }
    static var topicCell: UIImage { .load(name: "TopicCell") }
    static var deadLineCell: UIImage { .load(name: "DeadLineCell") }
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
    
