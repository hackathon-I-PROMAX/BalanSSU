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
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 17.0)
        return label
    }()
    
    let badge = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)).then {
        $0.backgroundColor = UIColor(red: 0.992, green: 0.969, blue: 0.898, alpha: 1)
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12.0)
        $0.textColor = UIColor(red: 0.746, green: 0.605, blue: 0.183, alpha: 1)
        $0.clipsToBounds = true // 요소가 삐져나가지 않도록 하는 속성
        $0.layer.cornerRadius = 8 // 둥글게 만드는 정도
        $0.textAlignment = .center
}
    
    let participant: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 12.0)
        label.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        return label
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
            $0.trailing.equalToSuperview().offset(-20)
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
