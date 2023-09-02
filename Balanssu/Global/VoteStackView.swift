//
//  VoteStackView.swift
//  Balanssu
//
//  Created by 김규철 on 2023/05/16.
//

import UIKit

import SnapKit
import Then

final class VoteStackView: UIStackView {
    
    var isSelected = false
    
    let optionButton = OptionChoiceButton(buttonType: .nonActive)
    let optionLabel = UILabel().then {
        $0.textColor = UIColor(r: 209, g: 209, b: 209)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 23)
        $0.textAlignment = .right
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        axis = .horizontal
        alignment = .center
        spacing = 20
        
        setViewHierarchy()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        addArrangedSubview(optionButton)
        addArrangedSubview(optionLabel)
    }
    
    private func setConstraints() {
        optionLabel.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
    }
}
