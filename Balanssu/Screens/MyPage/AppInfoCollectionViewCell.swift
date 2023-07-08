//
//  AppInfoCollectionViewCell.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/07/08.
//

import UIKit
import SnapKit

class AppInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "AppInfoCollectionViewCell"

    private(set) lazy var label = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConfigure()

        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setConfigure() {
        label.font = UIFont(name: "AppleSDGothicNeoM00", size: 16.0)
        label.textColor = .black
    }
}
