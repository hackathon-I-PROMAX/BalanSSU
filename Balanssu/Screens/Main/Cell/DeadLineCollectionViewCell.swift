//
//  DeadLineCollectionViewCell.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/19.
//

import UIKit

import SnapKit

import Then

import YDS

class DeadLineCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DeadLineCollectionViewCell"
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let deadLineTitleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    let badge = YDSBadge().then {
        $0.color = .blue
        $0.text = "결과"
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true // 요소가 삐져나가지 않도록 하는 속성
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarchy()
        setConstraints()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(deadLineTitleLabel)
        contentView.addSubview(badge)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
        
        deadLineTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top).offset(12)
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(17)
        }
        
        badge.snp.makeConstraints {
//            $0.top.equalTo(hotTitleLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalTo(imageView.snp.bottom).offset(-8)
            $0.height.equalTo(24)
        }
    }
    
    func configUI() {
        contentView.backgroundColor = .white
    }
    
}

