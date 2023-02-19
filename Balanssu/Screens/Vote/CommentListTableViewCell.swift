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
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 13.0)
    }()
        return label
    let badge = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)).then {
            $0.backgroundColor = UIColor(red: 0.992, green: 0.969, blue: 0.898, alpha: 1)
            $0.font = UIFont(name: "AppleSDGothicNeoR00", size: 11.0)
            $0.textColor = UIColor(red: 0.746, green: 0.605, blue: 0.183, alpha: 1)
            $0.clipsToBounds = true // 요소가 삐져나가지 않도록 하는 속성
            $0.layer.cornerRadius = 4 // 둥글게 만드는 정도
            $0.textAlignment = .center
    }
    let comment : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
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
        contentView.addSubview(badge)
        contentView.addSubview(comment)
    }
        
    private func autoLayout() {
        
        img.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
            $0.size.width.height.equalTo(32)
        }
        
        name.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(img.snp.trailing).offset(7)
        }
        
        badge.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalTo(name.snp.trailing).offset(5)
        }
        
        comment.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top:50, left: 15, bottom: 10, right: 15))
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

//extension CommentListTableViewCell {
//    public override func sizeThatFits(_ size: CGSize) -> CGSize
//}
