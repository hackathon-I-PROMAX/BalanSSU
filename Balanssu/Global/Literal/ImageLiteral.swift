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
    static var topicCell4: UIImage { .load(name: "TopicCell4") }
    static var deadLineCell: UIImage { .load(name: "DeadLineCell") }
    static var reportDefault: UIImage { .load(name: "report_default") }
    static var reportCheck: UIImage { .load(name: "report_check") }
    static var reportLabel: UIImage { .load(name: "reportLabel") }
    static var reportButtonCheck: UIImage { .load(name: "reportCheckButton_check") }
    static var reportButtonDefault: UIImage { .load(name: "reportCheckButton_default") }
    static var teamLabel: UIImage { .load(name: "Team_i_PROMAX") }
    static var cindy: UIImage { .load(name: "icon_cindy") }
    static var mike: UIImage { .load(name: "icon_mike") }
    static var joni: UIImage { .load(name: "icon_joni") }
    static var javier: UIImage { .load(name: "icon_javier") }
    static var bibi: UIImage { .load(name: "icon_bibi") }
    static var joeum: UIImage { .load(name: "icon_joeum") }
    static var julia: UIImage { .load(name: "icon_julia") }
    static var nine: UIImage { .load(name: "icon_nine") }
    static var chloe: UIImage { .load(name: "icon_chloe") }
    static var splash: UIImage { .load(name: "icon_splash") }

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
    
