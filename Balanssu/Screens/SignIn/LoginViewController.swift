//
//  LoginViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    let idLabel = UILabel().then {
        $0.text = "아이디"
        $0.textColor = .black
    }
    
    let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = .black
    }
    
    let idTextField = UITextField().then {
        $0.placeholder = "아이디를 입력해주세요."
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
    }

    let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요."
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
    }

    let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    let backButton = BackButton(type: .system)
    
    @objc func loginButtonTapped() {
        let loginAlert = UIAlertController(title: "🎉로그인 완료🎉", message: "이제 즐겁게 밸런슈를 즐기세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//            self.navigationController?.pushViewController(MainViewController(), animated: true)
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
        
        navigationItem.title = "로그인"
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
            $0.bottom.equalTo(view).offset(-669)
            $0.leading.equalTo(view).inset(20)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-554)
            $0.leading.equalTo(view).inset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-459)
            $0.leading.equalTo(view).inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-617)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-200)
            $0.leading.trailing.equalTo(view).inset(20)
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
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
    }
}