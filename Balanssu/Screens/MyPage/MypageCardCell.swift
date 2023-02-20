//
//  MypageCardCell.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/20.
//

import UIKit

class MypageCardCell: UITableViewCell {
    
    static let identifier = "MypageCardCell"
    
    let cardImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "card1")
        return img
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    
    private func addContentView() {
        contentView.addSubview(cardImage)
    }
        
    private func autoLayout() {
        cardImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
            $0.height.equalTo(186)
            $0.top.bottom.equalToSuperview().inset(3)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
