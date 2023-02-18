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
    }
    
    let genderLabel = UILabel().then {
        $0.text = "성별"
        $0.textColor = .black
    }
    
    let classLabel = UILabel().then {
        $0.text = "학번"
        $0.textColor = .black
    }
    
    let majorLabel = UILabel().then {
        $0.text = "학부"
        $0.textColor = .black
    }
    
    let nickNameTextField = UITextField().then {
        $0.placeholder = "사용하실 닉네임을 입력해주세요."
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "8자리 이상의 비밀번호를 입력해주세요."
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
    }
    
    let checkPasswordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 확인합니다."
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
    }
    
    let checkButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc func checkButtonTapped() {
        let loginAlert = UIAlertController(title: "🎉회원가입 완료🎉", message: "이제 즐겁게 밸런슈를 즐기세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
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
//        view.addSubview(passwordLabel)
//        view.addSubview(checkPasswordLabel)
        view.addSubview(checkButton)
    }
    
    override func setConstraints() {
        nickNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-669)
            $0.leading.equalTo(view).inset(20)
        }
        
        genderLabel.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-554)
            $0.leading.equalTo(view).inset(20)
        }
        
        classLabel.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-459)
            $0.leading.equalTo(view).inset(20)
        }
        
        majorLabel.snp.makeConstraints {
            $0.bottom.equalTo(view).offset(-617)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
//        nickNameTextField.snp.makeConstraints {
//            $0.bottom.equalTo(view).offset(-200)
//            $0.leading.trailing.equalTo(view).inset(20)
//        }
                
        //        checkPasswordTextField.snp.makeConstraints {
        //            $0.bottom.equalTo(view).offset(-100)
        //            $0.leading.trailing.equalTo(view).inset(20)
        //        }
                
                checkButton.snp.makeConstraints {
                    $0.bottom.equalTo(view).offset(-54)
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
    }
}
