//
//  SignUpViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import UIKit
import SnapKit

class SignUpViewController: BaseViewController, UITextFieldDelegate {
    let idLabel = UILabel().then {
        $0.text = "아이디"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let checkPasswordLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let idTextField = UITextField().then {
        $0.placeholder = "5자 이상의 아이디를 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        if self.idTextField.text?.isEmpty == false
            && self.idTextField.text!.count > 4
        {
//            self.checkIdLabel.textColor = UIColor(r: 64, g: 96, b: 160)
        } else {
            self.checkIdLabel.textColor = .white
        }
        
        if self.idTextField.text?.isEmpty == false
            && self.idTextField.text!.count > 4
        {
            idImageView.image = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
            idImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
        }
        else {
            idImageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
            idImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
        }
        
        if self.passwordTextField.text?.isEmpty == false
            && self.passwordTextField.text!.count > 7
        {
            passwordImageView.image = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
            passwordImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
        }
        else {
            passwordImageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
            passwordImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
        }
        
        if self.checkPasswordTextField.text?.isEmpty == false
            && self.checkPasswordTextField.text == self.passwordTextField.text
        {
            checkPasswordImageView.image = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
            checkPasswordImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
        }
        else {
            checkPasswordImageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
            checkPasswordImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
        }
        
        if self.checkPasswordTextField.text == self.passwordTextField.text {
            checkPasswordcheckLabel.textColor = .white
        } else {
            checkPasswordcheckLabel.textColor = UIColor(r: 64, g: 96, b: 160)
        }
        
        if self.idTextField.text!.count > 4
            && self.passwordTextField.text!.count > 7
            && self.checkPasswordTextField.text == self.passwordTextField.text
        {
            checkButton.isEnabled = true
            checkButton.setTitleColor(.white, for: .normal)
            checkButton.backgroundColor = UIColor(r: 64, g: 96, b: 160)
            checkButton.layer.borderWidth = 0
            checkButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        } else {
            checkButton.isEnabled = false
            checkButton.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
            checkButton.backgroundColor = .white
            checkButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
            checkButton.layer.borderWidth = 1
            checkButton.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        }
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "8자리 이상의 비밀번호를 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }

    let checkPasswordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 확인합니다"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }
    
    let checkIdLabel = UILabel().then {
        $0.text = "이미 사용중인 아이디입니다"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let checkIDButton = UIButton().then {
        $0.isEnabled = true
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    let checkPasswordcheckLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let idImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    let passwordImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    let checkPasswordImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    let checkButton = UIButton().then {
        $0.isEnabled = true
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
  
    @objc func checkButtonTapped() {
        let nextVC = SignUp2ViewController(username: idTextField.text, password: passwordTextField.text)
        self.navigationController?.pushViewController(nextVC, animated: true)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        checkPasswordTextField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        navigationItem.title = "회원가입"
        self.idTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        self.checkPasswordTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        self.navigationItem.leftBarButtonItem = backBarButton
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setViewHierarchy() {
        view.addSubview(idLabel)
        view.addSubview(passwordLabel)
        view.addSubview(checkPasswordLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(checkPasswordTextField)
        view.addSubview(passwordLabel)
        view.addSubview(checkIdLabel)
        view.addSubview(checkPasswordcheckLabel)
        view.addSubview(checkButton)
        view.addSubview(idImageView)
        view.addSubview(passwordImageView)
        view.addSubview(checkPasswordImageView)
    }
    
    override func setConstraints() {
        idLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(124)
            $0.leading.equalTo(view).inset(20)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(238)
            $0.leading.equalTo(view).inset(20)
        }
        
        checkPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(334)
            $0.leading.equalTo(view).inset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(147)
            $0.leading.equalTo(view).inset(20)
            $0.trailing.equalTo(view).inset(50)
            $0.height.equalTo(48)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(262)
            $0.leading.equalTo(view).inset(20)
            $0.trailing.equalTo(view).inset(50)
            $0.height.equalTo(48)
        }

        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(357)
            $0.leading.equalTo(view).inset(20)
            $0.trailing.equalTo(view).inset(50)
            $0.height.equalTo(48)
        }
        
        checkIdLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(199)
            $0.leading.trailing.equalTo(view).inset(28)
            $0.height.equalTo(16)
        }
        
        checkPasswordcheckLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(409)
            $0.leading.trailing.equalTo(view).inset(28)
            $0.height.equalTo(16)
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-54)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        idImageView.snp.makeConstraints {
            $0.top.equalTo(view).offset(161)
            $0.trailing.equalTo(view).offset(-22)
            $0.height.width.equalTo(20)
        }
        
        passwordImageView.snp.makeConstraints {
            $0.top.equalTo(view).offset(276)
            $0.trailing.equalTo(view).offset(-22)
            $0.height.width.equalTo(20)
        }
        
        checkPasswordImageView.snp.makeConstraints {
            $0.top.equalTo(view).offset(371)
            $0.trailing.equalTo(view).offset(-22)
            $0.height.width.equalTo(20)
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
