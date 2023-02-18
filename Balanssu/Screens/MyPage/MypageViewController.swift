//
//  MypageViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import SnapKit
import YDS

class MypageViewController: BaseViewController {
    let backButton = BackButton(type: .system)
    
    let contentView = UIView()
    
    let profileView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ppussung")
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.backgroundColor = .gray
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 20.0)
        label.textColor = .black
        label.text = "뿌슝이"
        label.textAlignment = .center
        return label
    }()
    
    let userInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.text = "글로벌미디어학부 / 20학번"
        label.textAlignment = .center
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.text = "@ppussung"
        label.textAlignment = .center
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        button.backgroundColor = nil
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moreButtonTap), for: .touchUpInside)
        return button
    }()
    let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "밸런스게임 질문을 만들고 싶다면?"
        label.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc
    func moreButtonTap() {
        print("=====질문만들기 버튼 클릭 =====")
        guard let url = URL(string: "https://www.naver.com"), UIApplication.shared.canOpenURL(url) else { return }
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func setViewHierarchy() {
        contentView.addSubview(profileView)
        contentView.addSubview(idLabel)
        contentView.addSubview(userInfo)
        contentView.addSubview(nameLabel)
        
        self.view.addSubview(contentView)
        self.view.addSubview(moreButton)
        moreButton.addSubview(moreLabel)
        
    }
    override func setConstraints() {
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(3)
            $0.top.equalToSuperview().offset(110)
            $0.height.equalTo(120)
        }
        
        profileView.snp.makeConstraints {
            $0.size.width.height.equalTo(100)
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(userInfo.snp.top).offset(-4)
            $0.leading.equalTo(profileView.snp.trailing).offset(11)
        }
        
        userInfo.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileView.snp.trailing).offset(11)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(userInfo.snp.bottom).offset(4)
            $0.leading.equalTo(profileView.snp.trailing).offset(11)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentView.snp.bottom).offset(16)
            $0.height.equalTo(49)
            $0.width.equalTo(335)
        }
        
        moreLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        profileView.layer.cornerRadius = 20
        
        setLayouts()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "마이페이지"
    }
    
}
