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
    static var topicCell1: UIImage { .load(name: "TopicCell1") }
    static var topicCell2: UIImage { .load(name: "TopicCell2") }
    static var topicCell3: UIImage { .load(name: "TopicCell3") }
    static var deadLineCell: UIImage { .load(name: "DeadLineCell") }
    static var deadLineCell2: UIImage { .load(name: "DeadLineCell2") }
    static var deadLineCell3: UIImage { .load(name: "DeadLineCell3") }
    static var reportDefault: UIImage { .load(name: "report_default") }
    static var reportCheck: UIImage { .load(name: "report_check") }
    static var reportLabel: UIImage { .load(name: "reportLabel") }
    static var reportButtonCheck: UIImage { .load(name: "reportCheckButton_check") }
    static var reportButtonDefault: UIImage { .load(name: "reportCheckButton_default") }

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
    
