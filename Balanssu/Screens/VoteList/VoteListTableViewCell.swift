//
//  VoteListTableViewCell.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import YDS

class VoteListTableViewCell: UITableViewCell {
    
    static let identifier = "VoteListTableViewCell"
    
    let voteTitle: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "AppleSDGothicNeoR00", size: 17.0)
        return lable
    }()
    
    let badge: YDSBadge = {
        let badge = YDSBadge()
        badge.color = .blue
        badge.layer.cornerRadius = 12
        return badge
    }()
    
    let participant: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "AppleSDGothicNeoR00", size: 12.0)
        lable.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        return lable
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    
    private func addContentView() {
        contentView.addSubview(badge)
        contentView.addSubview(voteTitle)
        contentView.addSubview(participant)
    }
        
    private func autoLayout() {
        badge.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        voteTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(badge.snp.trailing).offset(10)
        }
        
        participant.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-5)
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
