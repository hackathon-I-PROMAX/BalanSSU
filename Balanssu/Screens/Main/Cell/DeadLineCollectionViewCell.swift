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
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
    }
    
    func configUI() {
        contentView.backgroundColor = .systemRed
    }
    
}

