//
//  HotCollectionViewCell.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

import SnapKit

import Then

import YDS

class HotCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TopicCollectionViewCell"
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    var hotTitleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    let badge = YDSBadge().then {
        $0.color = .blue
        $0.text = "D-3"
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
        contentView.addSubview(hotTitleLabel)
        contentView.addSubview(badge)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
        
        badge.snp.makeConstraints {
//            $0.top.equalTo(hotTitleLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalTo(hotTitleLabel.snp.top).offset(-14)
            $0.height.equalTo(24)
        }
        
        hotTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(6)
            $0.height.equalTo(17)
        }
        
    }
    
    func configUI() {
        contentView.backgroundColor = .white
        imageView.layer.cornerRadius = 12
    }
    
}

