//
//  DeadLineCollectionViewHeader.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

import SnapKit

import Then

final class DeadLineCollectionViewHeader: UITableViewHeaderFooterView {

    static let identifier = "DeadLineCollectionViewHeader"
    
    private let hotTitleLabel = UILabel().then {
        $0.text = "마감된 밸런슈"
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 20)
        $0.textColor = .black
        $0.sizeToFit()
    }
    
    let deadLineListButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoR00", size: 14)
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
    
    private func setViewHierarchy() {
        addSubview(hotTitleLabel)
        addSubview(deadLineListButton)
    }
    
    private func setConstraints() {
         hotTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
             $0.bottom.equalToSuperview()
        }
         deadLineListButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
