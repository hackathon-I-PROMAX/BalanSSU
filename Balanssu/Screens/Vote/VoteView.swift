//
//  VoteView.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/24.
//

import UIKit
import Then
import YDS

final class VoteView: UIView {
    
    enum VoteViewType {
        case vote
        case nonVote
        case closed

        var isHidden: Bool {
            switch self {
            case .vote, .closed:
                return false
            case .nonVote:
                return true
            }
        }
        
        var title: String? {
            switch self {
            case .vote:
                return "이미 투표 했어요"
            case .nonVote:
                return "투표하기"
            case .closed:
                return "투표가 마감되었어요"
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .vote, .closed:
                return UIColor(r: 150, g: 150, b: 150)
            case .nonVote:
                return .white
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .vote, .closed:
                return UIColor(r: 240, g: 240, b: 240)
            case .nonVote:
                return UIColor(r: 64, g: 96, b: 160)
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .vote, .closed:
                return 0
            case .nonVote:
                return 1
            }
        }
    }
    
    let topicLabel = UILabel().then {
        $0.text = "술 먹고 다음날 일어났더니?"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 20)
    }
    
    let joinNumberLabel = UILabel().then {
        $0.text = "현재 100명 참여중"
        $0.textColor = UIColor(r: 125, g: 125, b: 125)
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let deadlineImageView = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 226, g: 231, b: 240)
    }

    let deadlineFinishedImageView = UIImageView().then {
        $0.image = UIImage(named: "Finished")
    }

    let deadlineLabel = UILabel().then {
        $0.text = "D-3"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 14)
    }
    let logoIconImageView = UIImageView().then {
        $0.image = UIImage(named: "logo.small")
    }
    
    let optionA = VoteStackView()
    let optionB = VoteStackView()
    
    let voteButton = UIButton().then {
        $0.setTitle("투표하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.backgroundColor = UIColor(r: 64, g: 96, b: 160)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViewHierarchy()
        setConstraints()
        configUI()
        setGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGestureRecognizer() {
        let optionATapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped(_:)))
        let optionBTapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped(_:)))
        optionA.addGestureRecognizer(optionATapGesture)
        optionB.addGestureRecognizer(optionBTapGesture)
    }
    
    private func setViewHierarchy() {
          addSubview(topicLabel)
          addSubview(joinNumberLabel)
          addSubview(deadlineImageView)
        addSubview(deadlineFinishedImageView)
          addSubview(deadlineLabel)
          addSubview(optionA)
          addSubview(optionB)
          addSubview(voteButton)
          addSubview(logoIconImageView)
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        topicLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().inset(16)
        }

        joinNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(56)
            $0.leading.equalToSuperview().inset(16)
        }
        
        deadlineImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(35)
        }
        
        deadlineFinishedImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(32)
            $0.width.equalTo(69)
        }

        deadlineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(22.5)
        }
        
        optionA.snp.makeConstraints {
            $0.top.equalTo(joinNumberLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(85)
        }
        
        optionB.snp.makeConstraints {
            $0.top.equalTo(optionA.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(85)
        }

        voteButton.snp.makeConstraints {
            $0.top.equalTo(optionB.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(250)
            $0.height.equalTo(47)
        }
        
        logoIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(voteButton)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(41)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
        self.layer.cornerRadius = 12
        
    }
}

extension VoteView {
    @objc private func stackViewTapped(_ gesture: UITapGestureRecognizer) {
        if gesture.view == optionA {
            optionA.optionButton.makeActiveTypeButton(status: .active)
            optionB.optionButton.makeActiveTypeButton(status: .nonActive)
            
            optionA.isSelected = !optionA.isSelected
            optionB.isSelected = false
        } else if gesture.view == optionB {
            optionB.optionButton.makeActiveTypeButton(status: .active)
            optionA.optionButton.makeActiveTypeButton(status: .nonActive)
            
            optionB.isSelected = !optionB.isSelected
            optionA.isSelected = false
        }
    }
    
    func makeVoteViewTypeView(status: VoteViewType) {
        voteButton.setTitle(status.title, for: .normal)
        voteButton.setTitleColor(status.titleColor, for: .normal)
        voteButton.backgroundColor = status.backgroundColor
        voteButton.layer.borderWidth = status.borderWidth

        optionA.isUserInteractionEnabled = false
        optionB.isUserInteractionEnabled = false
        
        optionA.optionLabel.isHidden = status.isHidden
        optionB.optionLabel.isHidden = status.isHidden
    }
}

