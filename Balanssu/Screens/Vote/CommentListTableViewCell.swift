//
//  CommentListTableViewCell.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit

class CommentListTableViewCell: UITableViewCell {
    
    static let identifier = "CommentListTableViewCell"
    
    let img = UIImageView()
    let name = UILabel()
    let comment = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    private func addContentView() {
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(comment)
    }
        
    private func autoLayout() {
        self.img.layer.cornerRadius = 22
        
        img.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.size.width.height.equalTo(40)
        }
        
        name.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(img.snp.trailing).offset(10)
            
        }
        
        comment.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
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
