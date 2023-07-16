//
//  WithDrawViewController.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/13.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

final class WithDrawViewController: BaseViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 탈퇴 전 확인해주세요!"
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 24)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "한 번 삭제된 정보는 복구가 불가능합니다.\n탈퇴 시 댓글은 ‘탈퇴한 사용자’로 표기됩니다.\n계정 탈퇴를 원하시면 해당 문장을 입력하세요."
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 16)
        label.numberOfLines = 0
        return label
    }()
    private let withDrawTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "밸런슈 그동안 고마웠어요"
        textField.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        textField.layer.cornerRadius = 8
        textField.textColor = .black
        textField.addLeftPadding()

        if let placeholder = textField.placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(r: 177, g: 177, b: 177)
            ])
            textField.attributedPlaceholder = attributedPlaceholder
        }
        return textField
    }()
    private var withDrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정을 탈퇴할게요", for: .normal)
        button.backgroundColor = UIColor.customColor(.defaultGray)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        button.layer.cornerRadius = 8
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.backgroundColor = UIColor.customColor(.defaultGray)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        button.layer.cornerRadius = 8
        return button
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubviews(withDrawButton, cancelButton)
        stackView.spacing = 10
        return stackView
    }()

    var viewModel: AccountViewModel

    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("MakeNicknameViewController Error!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        bindAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "탈퇴하기"
    }

    private func bind() {
        let input = AccountViewModel.Input(didWithDrawTextFieldChange: withDrawTextField.rx.text.orEmpty.asObservable(), tapConfirmButton: withDrawButton.rx.tap.asObservable().throttle(.seconds(1), scheduler: MainScheduler.instance))

        let output = viewModel.transform(input: input)

        output.alert
            .asDriver(onErrorJustReturn: .withDrawError)
            .drive(with:self) { owner, alertType in
                if alertType == .withDrawSuccess {
                    owner.errorPresentAlert(type: alertType, buttonAction: {
                        let startViewController = StartViewController()
                        owner.navigationController?.setViewControllers([startViewController], animated: true)
                    })
                } else if alertType == .withDrawError {
                    owner.errorPresentAlert(type: alertType)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        Observable.merge(cancelButton.rx.tap.asObservable(), realBackButton.rx.tap.asObservable())
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func setViewHierarchy() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(withDrawTextField)
        self.view.addSubview(buttonStackView)
    }

    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        withDrawTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(58)
        }

        withDrawButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-15)
        }
    }

}
