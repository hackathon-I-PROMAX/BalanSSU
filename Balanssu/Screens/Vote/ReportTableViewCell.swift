//
//  ReportTableViewCell.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/08/02.
//

import UIKit
import SnapKit
import Then

class ReportTableViewCell: UITableViewCell {

    static let identifier = "ReportTableViewCell"

    let checkButton = UIButton().then {
        $0.setImage(ImageLiterals.reportDefault, for: .normal)
        $0.isSelected = false
    }

    let contentLabel = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        $0.textColor = .black
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension ReportTableViewCell {
    private func addContentView() {
        contentView.addSubview(checkButton)
        contentView.addSubview(contentLabel)
    }

    private func autoLayout() {
        checkButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView)
            $0.width.height.equalTo(20)
        }

        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(6)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
}

