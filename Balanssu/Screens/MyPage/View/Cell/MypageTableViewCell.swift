//
//  MypageTableViewCell.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/06.
//

import UIKit

import SnapKit

class MypageTableViewCell: UITableViewCell {
    
    static let identifier = "MypageTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    private lazy var InfoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    func setData(text: String) {
        self.InfoLabel.text = text
    }
}

private extension MypageTableViewCell {
    func configureUI() {
        self.contentView.backgroundColor = .white
        
        [
            self.InfoLabel
        ].forEach {
            self.contentView.addSubview($0)
        }
    
        self.InfoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

