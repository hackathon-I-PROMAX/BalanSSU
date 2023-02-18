//
//  VoteListTableViewCell.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit

class VoteListTableViewCell: UITableViewCell {
    
    static let identifier = "VoteListTableViewCell"
    
    let voteTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [voteTitle].forEach {
            contentView.addSubview($0)
        }
        
        voteTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
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
