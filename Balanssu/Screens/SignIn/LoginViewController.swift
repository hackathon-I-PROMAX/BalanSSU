//
//  LoginViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController, UITextFieldDelegate {
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
    
    let idTextField = UITextField().then {
        $0.placeholder = "아이디를 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }

    let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }

    let loginButton = UIButton().then {
        $0.isEnabled = false
        $0.setTitle("로그인", for: .normal)
        $0.layer.cornerRadius = 8
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
//    let backBarButton = BackButton(type: .system)
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        if self.idTextField.text?.isEmpty == false
            && self.passwordTextField.text?.isEmpty == false
        {
            loginButton.isEnabled = true
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.backgroundColor = UIColor(r: 64, g: 96, b: 160)
            loginButton.layer.borderWidth = 0
            loginButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        } else {
            loginButton.isEnabled = false
            loginButton.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
            loginButton.backgroundColor = .white
            loginButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
            loginButton.layer.borderWidth = 1
            loginButton.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        }
    }
        
    @objc func loginButtonTapped() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        self.idTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        self.navigationItem.leftBarButtonItem = backBarButton
        navigationItem.title = "로그인"
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setViewHierarchy() {
        view.addSubview(idLabel)
        view.addSubview(passwordLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    override func setConstraints() {
        idLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(124)
            $0.leading.equalTo(view).inset(20)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(219)
            $0.leading.equalTo(view).inset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(147)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(242)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        loginButton.snp.makeConstraints {
//            $0.bottom.equalTo(view).offset(-200)
            $0.bottom.equalToSuperview().offset(-54)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
    }
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
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
        
//        super.setupNavigationBar()
//        
//        let backBarButton = makeBarButtonItem(with: backBarButton)
//        navigationItem.leftBarButtonItem = backBarButton
    }
}

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
