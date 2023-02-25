//
//  VoteView.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/24.
//

import UIKit
import Then
import YDS

class VoteView: BaseViewController {

    let testView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
        $0.layer.cornerRadius = 12
    }
    
    let topicLabel = UILabel().then {
        $0.text = "술 먹고 다음날 일어났더니?"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 20)
    }
    
    let joinNumberLabel = UILabel().then {
        $0.text = "현재 100명 참여중"
        $0.textColor = UIColor(r: 125, g: 125, b: 125)
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let deadlineImageView = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 226, g: 231, b: 240)
    }
    
    let deadlineLabel = UILabel().then {
        $0.text = "D-3"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 14)
    }
    
    let stackAView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .top
        $0.distribution = .fill
        $0.spacing = 50
    }
    
    let stackBView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .top
        $0.distribution = .fill
        $0.spacing = 50
    }
    
    let optionAButton = UIButton().then {
        $0.setTitle("전 애인한테 부재중 발신 21건", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoL00", size: 15)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .leading
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignTextLeft(spacing: 38)
        $0.addTarget(self, action: #selector(optionAButtonTapped), for: .touchUpInside)
    }
    
    let optionBButton = UIButton().then {
        $0.setTitle("전공교수님과 통화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoL00", size: 15)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .leading
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignTextLeft(spacing: 38)
        $0.addTarget(self, action: #selector(optionBButtonTapped), for: .touchUpInside)
    }
    
    let optionALabel = UILabel().then {
        $0.text = "36%"
        $0.textColor = UIColor(r: 209, g: 209, b: 209)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 24)
        $0.textAlignment = .center
    }
    
    let optionBLabel = UILabel().then {
        $0.text = "64%"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 24)
        $0.textAlignment = .center
    }
    
    let optionAImageView = UIImageView().then {
        $0.image = UIImage(named: "UnselectedOption")
    }
    
    let optionBImageView = UIImageView().then {
        $0.image = UIImage(named: "UnselectedOption")
    }
    
    let logoIconImageView = UIImageView().then {
        $0.image = UIImage(named: "logo.small")
    }
    
    let voteButton = UIButton().then {
        $0.setTitle("투표하기", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        $0.addTarget(self, action: #selector(voteButtonTapped), for: .touchUpInside)
    }
    
    lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: ImageLiterals.navigationBarBackButton, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()
    
    lazy var scrapBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "heart"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()
    
    @objc func backBarButtonTapped() {
        print("tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func voteButtonTapped() {
        if optionAButton.backgroundColor != .white ||
            optionBButton.backgroundColor != .white {
            voteButton.isEnabled = false
            voteButton.setTitle("이미 투표했어요", for: .normal)
            voteButton.setTitleColor(UIColor(r: 150, g: 150, b: 150), for: .normal)
            voteButton.backgroundColor = UIColor(r: 240, g: 240, b: 240)
            voteButton.layer.borderWidth = 0
            
            optionAButton.isEnabled = false
            optionBButton.isEnabled = false
            
            // if choose A
            if optionBButton.backgroundColor == .white {
                optionAButton.setTitleColor(.white, for: .normal)
                optionAButton.backgroundColor = UIColor(r: 64, g: 96, b: 160)
                optionAButton.layer.borderWidth = 0
                
                optionBButton.setTitleColor(UIColor(r: 150, g: 150, b: 150), for: .normal)
                optionBButton.backgroundColor = UIColor(r: 240, g: 240, b: 240)
                optionBButton.layer.borderWidth = 0
                
                optionAImageView.image = UIImage(named: "SelectedOptionResult")
                optionAImageView.tintColor = .white
                
                optionBImageView.isHidden = true
                
                optionALabel.isHidden = false
                optionBLabel.isHidden = false
                
                optionALabel.textColor = UIColor(r: 64, g: 96, b: 160)
                optionBLabel.textColor = UIColor(r: 209, g: 209, b: 209)
            }
            
            // if B choose
            if optionAButton.backgroundColor == .white {
                optionAButton.setTitleColor(UIColor(r: 150, g: 150, b: 150), for: .normal)
                optionAButton.backgroundColor = UIColor(r: 240, g: 240, b: 240)
                optionAButton.layer.borderWidth = 0
                
                optionBButton.setTitleColor(.white, for: .normal)
                optionBButton.backgroundColor = UIColor(r: 64, g: 96, b: 160)
                optionBButton.layer.borderWidth = 0
                
                optionBImageView.image = UIImage(named: "SelectedOptionResult")
                optionBImageView.tintColor = .white
                
                optionAImageView.isHidden = true
                
                optionALabel.isHidden = false
                optionBLabel.isHidden = false
                
                optionALabel.textColor = UIColor(r: 209, g: 209, b: 209)
                optionBLabel.textColor = UIColor(r: 64, g: 96, b: 160)
            }
        }
    }
    
    @objc func optionAButtonTapped() {
        optionAButton.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        optionAButton.backgroundColor = UIColor(r: 226, g: 231, b: 240)
        optionAButton.layer.borderWidth = 0
        optionAImageView.image = UIImage(named: "SelectedOption")

        
        optionBButton.setTitleColor(.black, for: .normal)
        optionBButton.backgroundColor = .white
        optionBButton.layer.borderWidth = 1
        optionBImageView.image = UIImage(named: "UnselectedOption")

    }
    
    @objc func optionBButtonTapped() {
        optionAButton.setTitleColor(.black, for: .normal)
        optionAButton.backgroundColor = .white
        optionAButton.layer.borderWidth = 1
        optionAImageView.image = UIImage(named: "UnselectedOption")

        optionBButton.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        optionBButton.backgroundColor = UIColor(r: 226, g: 231, b: 240)
        optionBButton.layer.borderWidth = 0
        optionBImageView.image = UIImage(named: "SelectedOption")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        self.navigationItem.leftBarButtonItem = backBarButton
        self.navigationItem.rightBarButtonItem = scrapBarButton
        optionALabel.isHidden = true
        optionBLabel.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setViewHierarchy() {
        view.addSubview(testView)
        view.addSubview(stackAView)
        view.addSubview(stackBView)
        testView.addSubview(topicLabel)
        testView.addSubview(joinNumberLabel)
        testView.addSubview(deadlineImageView)
        testView.addSubview(deadlineLabel)
        testView.addSubview(voteButton)
        testView.addSubview(logoIconImageView)
        stackAView.addArrangedSubview(optionAButton)
        stackAView.addArrangedSubview(optionALabel)
        stackBView.addArrangedSubview(optionBButton)
        stackBView.addArrangedSubview(optionBLabel)
        optionAButton.addSubview(optionAImageView)
        optionBButton.addSubview(optionBImageView)
    }
    
    override func setConstraints() {
        testView.snp.makeConstraints {
            $0.top.equalTo(view).offset(104)
            $0.leading.equalTo(view).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
            $0.height.equalTo(344)
        }
        
        topicLabel.snp.makeConstraints {
            $0.top.equalTo(testView).offset(24)
            $0.leading.equalTo(testView).inset(16)
        }

        joinNumberLabel.snp.makeConstraints {
            $0.top.equalTo(testView).offset(56)
            $0.leading.equalTo(testView).inset(16)
        }
        
        deadlineImageView.snp.makeConstraints {
            $0.top.equalTo(testView).offset(20)
            $0.trailing.equalTo(testView).inset(16)
            $0.height.width.equalTo(35)
        }
        
        deadlineLabel.snp.makeConstraints {
            $0.top.equalTo(testView).offset(28)
            $0.trailing.equalTo(testView).inset(22.5)
        }

        voteButton.snp.makeConstraints {
            $0.top.equalTo(testView).offset(279)
            $0.leading.equalTo(testView).inset(16)
            $0.width.equalTo(250)
            $0.height.equalTo(47)
        }
        
        logoIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(voteButton)
            $0.trailing.equalTo(testView).inset(16)
            $0.height.width.equalTo(41)
        }
        
        stackAView.snp.makeConstraints {
            $0.top.equalTo(testView).offset(83)
            $0.leading.trailing.equalTo(testView).inset(16)
            $0.height.equalTo(85)
            //$0.width.equalTo(100)
        }
        
        optionAButton.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        optionAImageView.snp.makeConstraints {
            $0.centerY.equalTo(optionAButton)
            $0.trailing.equalTo(optionAButton).inset(20)
            $0.height.width.equalTo(28)
        }
        
        optionALabel.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalTo(stackAView).inset(0)
            $0.width.equalTo(50)
//            $0.leading.equalTo(optionBButton).inset(-50)
        }
        
        stackBView.snp.makeConstraints {
            $0.top.equalTo(testView).offset(180)
            $0.leading.trailing.equalTo(testView).inset(16)
            $0.height.equalTo(85)
        }
        
        optionBButton.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        optionBImageView.snp.makeConstraints {
            $0.centerY.equalTo(optionBButton)
            $0.trailing.equalTo(optionBButton).inset(20)
            $0.height.width.equalTo(28)
        }
        
        optionBLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalTo(stackBView).inset(0)
            $0.width.equalTo(50)
//            $0.leading.equalTo(optionBButton).inset(0)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
    
    override func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
        
    override func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
                
        super.setupNavigationBar()
    }
}

extension UIButton {
    func alignTextLeft(spacing: CGFloat = 8.0) {
//        contentHorizontalAlignment = .leading
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
//        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
//        imageEdgeInsets = UIEdgeInsets(top: 0, left: 144, bottom: 0, right: 0)
//        contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
    }
}
