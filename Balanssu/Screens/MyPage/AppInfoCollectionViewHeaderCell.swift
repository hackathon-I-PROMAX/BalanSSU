
//
//  AppInfoCollectionViewHeaderCell.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/07/08.
//

import UIKit
import SnapKit

class AppInfoCollectionViewHeaderCell: UICollectionReusableView {
    static let identifier = "AppInfoCollectionViewHeaderCell"

    private(set) lazy var label = UILabel()

    func setConfigure() {
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 16.0)
        label.textColor = .black
    }

    public func configure() {
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConfigure()

        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.centerY.equalToSuperview()
        }
    }
}
