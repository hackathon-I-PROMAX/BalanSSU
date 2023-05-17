//
//  OptionChoiceButton.swift
//  Balanssu
//
//  Created by 김규철 on 2023/05/16.
//

import UIKit

import SnapKit
import Then

final class OptionChoiceButton: UIView {
    
    enum ButtonActive {
        case active
        case nonActive
        
        var titleColor: UIColor {
            switch self {
            case .active:
                return UIColor.customColor(.choiceButtonText)
            case .nonActive:
                return .black
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .active:
                return UIColor(r: 226, g: 231, b: 240)
            case .nonActive:
                return .white
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .active:
                return 0
            case .nonActive:
                return 1
            }
        }
        
        var optionImage: UIImage? {
            switch self {
            case .active:
                return UIImage(named: "SelectedOption")
            case .nonActive:
                return UIImage(named: "UnselectedOption")
            }
        }
    }
        
    var optionTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont(name: "AppleSDGothicNeoL00", size: 15)
    }
    
    var optionAImageView = UIImageView().then {
        $0.image = UIImage(named: "UnselectedOption")
    }
    
    init(buttonType: ButtonActive) {
        super.init(frame: .zero)
        setViewHierarchy()
        setConstraints()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        addSubview(optionTitleLabel)
        addSubview(optionAImageView)
    }
    
    private func setConstraints() {
        optionTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(100)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        optionAImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(27)
        }
    }
    
    private func configUI() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
    }
}

extension OptionChoiceButton {
      func configureButton(status: ButtonActive) {
        optionTitleLabel.textColor = status.titleColor
        optionAImageView.image = status.optionImage
        self.backgroundColor = status.backgroundColor
        self.layer.borderWidth = status.borderWidth
    }
}
