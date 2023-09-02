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
import RxCocoa
import YDS

final class StartViewController: BaseViewController {
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var signInButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(r: 64, g: 96, b: 160)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    private lazy var signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.backgroundColor = UIColor(r: 232, g: 236, b: 244)
        $0.layer.cornerRadius = 8
    }

    //    private lazy var findPasswordButton = YDSLabel(style: .body1).then {
    //        $0.text = "비밀번호 찾기"
    //        $0.textColor = UIColor(r: 125, g: 125, b: 125)
    //    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.realBackButton.isHidden = true
        
    }
    
    func bindAction() {
        signInButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.pushViewController(SignUpViewController(viewModel: SetAuthViewModel(authDataSource: DefaultAuthDataSource())), animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func setViewHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        //        view.addSubview(findPasswordButton)
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
        
        //        findPasswordButton.snp.makeConstraints {
        //            $0.bottom.equalToSuperview().offset(-54)
        //            $0.centerX.equalToSuperview()
        //            $0.height.equalTo(17)
        //        }
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
