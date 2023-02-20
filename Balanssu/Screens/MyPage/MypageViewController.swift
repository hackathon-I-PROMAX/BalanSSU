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
    
    private let profileView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ppussung")
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 20.0)
        label.textColor = .black
        label.text = "뿌슝이"
        label.textAlignment = .center
        return label
    }()
    
    private let userInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.text = "글로벌미디어학부 / 20학번"
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.text = "@ppussung"
        label.textAlignment = .center
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        button.backgroundColor = nil
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moreButtonTap), for: .touchUpInside)
        return button
    }()
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "밸런스게임 질문을 만들고 싶다면?"
        label.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.943, green: 0.943, blue: 0.943, alpha: 1)
        return view
    }()
    private let cardLabel: UILabel = {
        let label = UILabel()
        label.text = "모은 밸런슈 카드"
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 20.0)
        return label
    }()
    private let tableView : UITableView = { // 테이블 뷰 생성
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MypageCardCell.self, forCellReuseIdentifier: MypageCardCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 190
        return tableView
    }()
    let card: [String] = ["card1", "card2","card3"]
    
    @objc
    func moreButtonTap() {
        print("=====질문만들기 버튼 클릭 =====")
        guard let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScUWg9XFi7fnVLgcJux0kTPLB1yzBjzIUU_BdR19XzGjyccMQ/viewform"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: ImageLiterals.navigationBarBackButton, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
        return button
    }()
    
    @objc func backBarButtonTapped() {
        print("tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func setViewHierarchy() {
        contentView.addSubview(profileView)
        contentView.addSubview(idLabel)
        contentView.addSubview(userInfo)
        contentView.addSubview(nameLabel)
        
        self.view.addSubview(contentView)
        self.view.addSubview(moreButton)
        moreButton.addSubview(moreLabel)
        
        self.view.addSubview(grayLine)
        self.view.addSubview(cardLabel)
        self.view.addSubview(tableView)
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
        
        grayLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(moreButton.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(4)
        }
        cardLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.top.equalTo(grayLine.snp.bottom).offset(20)
        }
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(cardLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview()
        }
            
    }
    func setLayouts() {
        tableView.dataSource = self
        tableView.delegate = self
        
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = backBarButton
        
        setLayouts()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "마이페이지"
    }
}

extension MypageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MypageCardCell.identifier, for: indexPath) as! MypageCardCell
        let cardImage = UIImage(named: "\(card[indexPath.row]).png")
        cell.cardImage.image = cardImage
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension MypageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}

