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
import YDS

class StartViewController: BaseViewController {
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "apple.logo")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    let signInButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(r: 64, g: 96, b: 160)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    let signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

    let findPasswordButton = YDSLabel(style: .body1).then {
        $0.text = "비밀번호 찾기"
        $0.textColor = UIColor(r: 125, g: 125, b: 125)
    }
    
    let browsingBarButton = UIButton().then {
        $0.setTitle("둘러보기", for: .normal)
        $0.setTitleColor(UIColor(r: 125, g: 125, b: 125), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 14)
//        $0.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    let backButton = BackButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        
        navigationItem.title = "밸런슈"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setViewHierarchy() {
        view.addSubview(logoImageView)
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
            $0.top.equalTo(view).offset(190)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        signInButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(20)
            $0.bottom.equalToSuperview().offset(-145)
            $0.height.equalTo(48)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(20)
            $0.bottom.equalToSuperview().offset(-85)
            $0.height.equalTo(48)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-54)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
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

        let browsingBarButton = makeBarButtonItem(with: browsingBarButton)
        navigationItem.rightBarButtonItem = browsingBarButton
    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
