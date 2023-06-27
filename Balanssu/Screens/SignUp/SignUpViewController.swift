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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        bind()
        bindAction()
        setupNotificationCenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "회원가입"
    }
    
    
    private func bind() {
        let input = SetAuthViewModel.Input(didIdTextFieldChange: idTextField.rx.text.orEmpty.asObservable(), didPasswordTextFieldChange: passwordTextField.rx.text.orEmpty.asObservable(), didPasswordCheckTextFieldChange: checkPasswordTextField.rx.text.orEmpty.asObservable(), didPasswordTextFieldDidTapEvent: checkPasswordTextField.rx.controlEvent(.editingChanged).asObservable(), didIdValidationEvent: idTextField.rx.controlEvent(.editingDidEnd).asObservable(), tapConfirmButton: checkButton.rx.tap.asObservable().throttle(.seconds(3), scheduler: MainScheduler.instance))
        let output = viewModel.transform(input: input)
        
        output.isIdValid
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, result in
                owner.idImageView.image = result ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
            }
            .disposed(by: disposeBag)
        
        output.didIdDuplicateCheck
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, result in
            owner.checkIdLabel.isHidden = result
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
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, result in
                owner.checkButton.isEnabled = result
                owner.checkButton.backgroundColor = result ? UIColor(r: 64, g: 96, b: 160) : UIColor.customColor(.defaultGray)
            }
            .disposed(by: disposeBag)
        
        output.didConfirmButtonTapped
            .bind { [weak self] (id, pwd) in
                let userInfoViewController = SignUp2ViewController(username: id, password: pwd)
                self?.navigationController?.pushViewController(userInfoViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func bindAction() {
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
        
        realBackButton.rx.tap
            .bind { self.navigationController?.popViewController(animated: true) }
            .disposed(by: disposeBag)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private let idLabel = UILabel().then {
        $0.text = "아이디"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    private let checkPasswordLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    private let idTextField = UITextField().then {
        $0.placeholder = "영/숫자 포함 8자리 이상"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.textColor = .black
        $0.addLeftPadding()
        $0.keyboardType = .asciiCapable
        
        if let placeholder = $0.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(r: 177, g: 177, b: 177)
            ])
            $0.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "영/숫자/특수 포함 8자리 이상"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.isSecureTextEntry = true
        $0.textColor = .black
        $0.addLeftPadding()
        
        if let placeholder = $0.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(r: 177, g: 177, b: 177)
            ])
            $0.attributedPlaceholder = attributedPlaceholder
        }
    }

    private let checkPasswordTextField = UITextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.isSecureTextEntry = true
        $0.textColor = .black
        $0.addLeftPadding()
        
        if let placeholder = $0.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(r: 177, g: 177, b: 177)
            ])
            $0.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    private lazy var checkIdLabel = UILabel().then {
        $0.text = "3자 이하 혹은 이미 사용중인 아이디입니다"
        $0.textColor = .red
        $0.isHidden = true
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    private lazy var checkPasswordcheckLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.isHidden = true
        $0.textColor = .red
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    private lazy var PasswordcheckLabel = UILabel().then {
        $0.text = "영소문자/숫자/특수문자 포함 8자리 이상 입력해주세요."
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.isHidden = true
        $0.textColor = .red
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    private let idImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    private let passwordImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    private let checkPasswordImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    private var checkButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = UIColor.customColor(.defaultGray)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.layer.cornerRadius = 8
    }
    
    private let idStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    private let passwordStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    private let passwordCheckStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
      
    override func setViewHierarchy() {
        [idTextField, idImageView].forEach { subView in
            idStackView.addArrangedSubview(subView)
        }
        
        [passwordTextField, passwordImageView].forEach { subView in
            passwordStackView.addArrangedSubview(subView)
        }
        
        [checkPasswordTextField, checkPasswordImageView].forEach { subView in
            passwordCheckStackView.addArrangedSubview(subView)
        }
        
        view.addSubview(idStackView)
        view.addSubview(passwordStackView)
        view.addSubview(passwordCheckStackView)
        view.addSubview(idLabel)
        view.addSubview(passwordLabel)
        view.addSubview(checkPasswordLabel)
        view.addSubview(PasswordcheckLabel)
        view.addSubview(passwordLabel)
        view.addSubview(checkIdLabel)
        view.addSubview(checkPasswordcheckLabel)
        view.addSubview(checkButton)
    }
    
    override func setConstraints() {
        idLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalTo(view).inset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        
        idImageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
    
        idStackView.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        checkIdLabel.snp.makeConstraints {
            $0.top.equalTo(idStackView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(16)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(idStackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        
        passwordImageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        passwordStackView.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        PasswordcheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordStackView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(16)
        }
        
        checkPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordStackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        
        checkPasswordImageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        passwordCheckStackView.snp.makeConstraints {
            $0.top.equalTo(checkPasswordLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        checkPasswordcheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordCheckStackView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(16)
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let textFieldHeight = checkPasswordTextField.frame.height

        guard checkPasswordTextField.isFirstResponder else { return }
        UIView.animate(
            withDuration: 0.3
            , animations: {
                self.view.frame.origin.y -= (textFieldHeight)
                self.view.layoutIfNeeded()
            }
        )
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        let textFieldHeight = checkPasswordTextField.frame.height
        
        guard checkPasswordTextField.isFirstResponder else { return }
        UIView.animate(
            withDuration: 0.3
            , animations: {
                self.view.frame.origin.y += (textFieldHeight)
                self.view.layoutIfNeeded()
            }
        )
    }
}
