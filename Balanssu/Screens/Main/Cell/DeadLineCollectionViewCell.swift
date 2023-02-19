//
//  DeadLineCollectionViewCell.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/19.
//

import UIKit

import SnapKit

import Then

class DeadLineCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DeadLineCollectionViewCell"
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let deadLineTitleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
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
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
        
        deadLineTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(6)
            $0.height.equalTo(17)
        }
    }
    
    func configUI() {
        contentView.backgroundColor = .white
    }
    
}

