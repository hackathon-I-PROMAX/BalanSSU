//
//  DeveloperInfoTableViewCell.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/07/08.
//

import UIKit

class DeveloperInfoTableViewCell: UITableViewCell {
    static let identifier = "DeveloperInfoTableViewCell"
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profileImage")

        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 15.0)
//        label.text = "Bibi\niOS"
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    private func addContentView() {
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
    }
        
    private func autoLayout() {
        profileImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(53)
            $0.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

