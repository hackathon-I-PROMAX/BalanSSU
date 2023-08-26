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
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .gray
        // view.layer.borderWidth = 1.0
        // view.layer.borderColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1).cgColor
        return view
    }()
    let name : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoM00", size: 13.0)
        return label
    }()
    let badge = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)).then {
            $0.backgroundColor = UIColor(red: 0.992, green: 0.969, blue: 0.898, alpha: 1)
            $0.font = UIFont(name: "AppleSDGothicNeoR00", size: 11.0)
            $0.textColor = UIColor(red: 0.746, green: 0.605, blue: 0.183, alpha: 1)
            $0.clipsToBounds = true // 요소가 삐져나가지 않도록 하는 속성
            $0.layer.cornerRadius = 4 // 둥글게 만드는 정도
            $0.textAlignment = .center
    }
    let reportButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "report"), for: .normal)
        return button
    }()
    let commentLabel : UILabel = {
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

    override func prepareForReuse() {
        super.prepareForReuse()
        reportButton.isHidden = false
    }

    private func addContentView() {
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(badge)
        contentView.addSubview(reportButton)
        contentView.addSubview(commentLabel)
    }
        
    private func autoLayout() {
        
        img.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.size.width.height.equalTo(30)
        }
        
        name.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(img.snp.trailing).offset(7)
        }
        
        badge.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(name.snp.trailing).offset(5)
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(17)
            $0.width.equalTo(14)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(img.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
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
