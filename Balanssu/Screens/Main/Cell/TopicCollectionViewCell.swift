//
//  TopicCollectionViewCell.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

import SnapKit

import Then

class TopicCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TopicCollectionViewCell"
    
    var bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
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
        contentView.addSubview(bannerImageView)
    }
    
    func setConstraints() {
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configUI() {
        contentView.layer.backgroundColor = UIColor.customColor(.defaultBlue).cgColor
    }
    
}
