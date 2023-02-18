//
//  SignUp2ViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import UIKit
import SnapKit

class SignUp2ViewController: BaseViewController {
    let nickNameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let genderLabel = UILabel().then {
        $0.text = "성별"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let classLabel = UILabel().then {
        $0.text = "학번"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let majorLabel = UILabel().then {
        $0.text = "학부"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let nickNameTextField = UITextField().then {
        $0.placeholder = "   사용하실 닉네임을 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
    }
    
    let genderTextField = UITextField().then {
        $0.placeholder = "   성별을 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
    }
    
    let classTextField = UITextField().then {
        $0.placeholder = "   학번을 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
    }
    
    let majorTextField = UITextField().then {
        $0.placeholder = "   학부를 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
    }
    
    let checkNickNameLabel = UILabel().then {
        $0.text = "이미 사용중인 닉네임입니다"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let nickNameImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    let checkButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(r: 64, g: 96, b: 160)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    let backBarButton = BackButton(type: .system)
    
    @objc func checkButtonTapped() {
        let loginAlert = UIAlertController(title: "🎉회원가입 완료🎉", message: "이제 즐겁게 밸런슈를 즐기세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.pushViewController(StartViewController(), animated: true)
        }
        loginAlert.addAction(okAction)
        self.present(loginAlert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        
        navigationItem.title = "회원가입"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setViewHierarchy() {
        view.addSubview(nickNameLabel)
        view.addSubview(genderLabel)
        view.addSubview(classLabel)
        view.addSubview(majorLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(genderTextField)
        view.addSubview(classTextField)
        view.addSubview(majorTextField)
        view.addSubview(checkButton)
        view.addSubview(checkNickNameLabel)
        view.addSubview(nickNameImageView)
    }
    
    override func setConstraints() {
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(124)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(239)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        classLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(334)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(429)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(147)
            $0.leading.equalTo(view).inset(20)
            $0.trailing.equalTo(view).inset(50)
            $0.height.equalTo(48)
        }
        
        genderTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(262)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        classTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(357)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
            
        majorTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(452)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        checkNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(199)
            $0.leading.trailing.equalTo(view).inset(28)
        }
        
        nickNameImageView.snp.makeConstraints {
            $0.top.equalTo(view).offset(161)
            $0.trailing.equalTo(view).offset(-22)
            $0.height.width.equalTo(20)
        }
                
        checkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-54)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
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
        
        let backBarButton = makeBarButtonItem(with: backBarButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
}
