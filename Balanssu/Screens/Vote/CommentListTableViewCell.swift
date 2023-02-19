//
//  CommentListTableViewCell.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit

class CommentListTableViewCell: UITableViewCell {
    
    static let identifier = "CommentListTableViewCell"
    
    let img : UIImageView = {
        let view = UIImageView()
        view.image = UIImage()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .gray
        return view
    }()
    let name : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoB", size: 13.0)
        return label
    }()
    let comment : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoM", size: 15.0)
        return label
    }()
    
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
