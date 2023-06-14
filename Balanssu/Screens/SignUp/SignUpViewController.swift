//
//  SignUpViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

class SignUpViewController: BaseViewController, UITextFieldDelegate {
    
    private var disposeBag = DisposeBag()
    var viewModel: SetAuthViewModel
    
    init(viewModel: SetAuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MakeNicknameViewController Error!")
    }
    
    
    private func bind() {
//        let input = SetAuthViewModel.Input(didIdTextFieldChange: idTextField.rx.text.orEmpty.asObservable(), didPasswordTextFieldChange: passwordTextField.rx.text.orEmpty.asObservable(), didPasswordCheckTextFieldChange: checkPasswordTextField.rx.text.orEmpty.asObservable(), tapConfirmButton:checkButton.rx.tap.asObservable())
        let input = SetAuthViewModel.Input(didIdTextFieldChange: idTextField.rx.text.orEmpty.asObservable(), didPasswordTextFieldChange: passwordTextField.rx.text.orEmpty.asObservable(), didPasswordCheckTextFieldChange: checkPasswordTextField.rx.text.orEmpty.asObservable(), didPasswordTextFieldDidTapEvent: checkPasswordTextField.rx.controlEvent(.editingChanged).asObservable(), tapConfirmButton: checkButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.isIdValid
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, result in
                owner.idImageView.image = result ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
            }
            .disposed(by: disposeBag)

        output.isPasswordValid
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, result in
                owner.passwordImageView.image = result ? UIImage(systemName: "checkmark.circle.fill") :UIImage(systemName: "checkmark.circle")
                owner.PasswordcheckLabel.isHidden = result
            }
            .disposed(by: disposeBag)
        
        output.isPasswordCheckValid
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, result in
                owner.checkPasswordImageView.image = result ? UIImage(systemName: "checkmark.circle.fill") :UIImage(systemName: "checkmark.circle")
                owner.checkPasswordcheckLabel.isHidden = result
            }
            .disposed(by: disposeBag)
        
        output.isAllInputValid
            .debug()
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, result in
                owner.checkButton.isEnabled = result
                owner.checkButton.backgroundColor = result ? UIColor.black : UIColor.systemRed
            }
            .disposed(by: disposeBag)
        
        
        // textFieldShouldReturn (리턴키 선택 시 키보드를 닫기)
        idTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.idTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.passwordTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        checkPasswordTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] _ in
                self?.checkPasswordTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
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
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "8자리 이상의 비밀번호를 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
//        $0.isSecureTextEntry = true
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
    
    lazy var checkPasswordcheckLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.isHidden = true
        $0.textColor = .red
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    lazy var PasswordcheckLabel = UILabel().then {
        $0.text = "8 자리 이상 비밀번호 입력해주세요"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.isHidden = true
        $0.textColor = .red
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
    
    var checkButton = UIButton().then {
//        $0.isEnabled = true
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
//        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
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
        bind()
        navigationItem.title = "회원가입"
        self.navigationItem.leftBarButtonItem = backBarButton

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
        view.addSubview(PasswordcheckLabel)
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
        
        PasswordcheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(view).inset(28)
            $0.height.equalTo(16)
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
