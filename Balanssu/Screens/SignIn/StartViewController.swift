//
//  StartViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import UIKit
import SnapKit
import Then
import RxSwift
//import YDS

class StartViewController: BaseViewController {
    
    var signInButton = UIButton().then {
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    var signUpButton = UIButton().then {
        $0.setTitle("SignUp", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor.lightGray
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

    let findPasswordButton = UILabel().then {
        $0.text = "비밀번호 찾기"
        $0.textColor = .black
    }
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "pencil")
        $0.contentMode = .scaleAspectFit
    }
    
    let browsingBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        
        navigationItem.title = "밸런슈"
        navigationController?.navigationItem.rightBarButtonItems = [browsingBarButton]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setViewHierarchy() {
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(findPasswordButton)
    }
    
    @objc func signInButtonTapped() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func signUpButtonTapped() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    
    override func setConstraints() {
        logoImageView.snp.makeConstraints {
//            $0.bottom.equalTo(view).offset(-422)
//            $0.leading.trailing.equalTo(view).inset(88)
            $0.width.height.equalTo(200)
        }
        
        signInButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(20)
            $0.bottom.equalTo(view).offset(-144)
//            $0.height.equalTo(48)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(20)
            $0.bottom.equalTo(view).offset(-84)
//            $0.height.equalTo(48)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(144)
            $0.bottom.equalTo(view).offset(-53)
//            $0.height.equalTo(72)
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
