//
//  HotCollectionViewHeader.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

import SnapKit

import Then

class HotCollectionViewHeader: UITableViewHeaderFooterView {

    static let identifier = "HotCollectionViewHeader"
    
    private let hotTitleLabel = UILabel().then {
        $0.text = "지금 HOT한 밸런슈"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.sizeToFit()
    }
    
    let allListButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitleColor(UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1), for: .normal)
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViewHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setViewHierarchy() {
        addSubview(hotTitleLabel)
        addSubview(allListButton)
         
    }
     func setConstraints() {
        
         hotTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
             $0.bottom.equalToSuperview().inset(17)
        }
         
         allListButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(17)
        }
         
    }
}

