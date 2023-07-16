//
//  BalanSSUPopup.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/08.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

typealias ButtonAction = () -> Void?

final class BalanSSUPopup: UIViewController {
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.backgroundColor = .white
        return v
    }()
        
    lazy var buttonStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.alignment = .center
        v.addArrangedSubviews(leftButton, rightButton)
        v.spacing = 30
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont(name: "AppleSDGothicNeoB00", size: 20.0)
        v.textColor = .black
        return v
    }()
    
    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        v.numberOfLines = 0
        v.textAlignment = .center
        v.textColor = .black
        return v
    }()
    
    lazy var leftButton: UIButton = {
        let v = UIButton()
        v.setTitleColor(.black, for: .normal)
        v.titleLabel?.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        return v
    }()
    
    lazy var rightButton: UIButton = {
        let v = UIButton()
        v.setTitleColor(.black, for: .normal)
        v.titleLabel?.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        return v
    }()
    
    private let disposeBag: DisposeBag = .init()
    private var leftButtonAction: ButtonAction?
    private var rightButtonAction: ButtonAction?
    private var alertType: AlertType
    
    init(alertType: AlertType) {
        self.alertType = alertType
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        updateUI()

        leftButton.rx.tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { owner, _ in
                owner.leftButtonAction?()
                owner.dismiss()
            })
            .disposed(by: disposeBag)

        rightButton.rx.tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { owner, _ in
                owner.rightButtonAction?()
                owner.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    
    func present(
        on viewController: UIViewController,
        alertType: AlertType,
        leftButtonAction: ButtonAction? = nil,
        rightButtonAction: ButtonAction? = nil
    ) {
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction

        
        viewController.present(self, animated: false) {
            UIView.animate(withDuration: 0.5, animations: {
                self.contentView.alpha = 1
                self.view.alpha = 1
            })
        }
    }
        
    func dismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
            self.view.alpha = 0
        }, completion: { flag in
            if flag {
                self.dismiss(animated: false)
            }
        })
    }
    
    func setUI() {
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(buttonStackView)
                
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.alpha = 0
        contentView.alpha = 0
        
        contentView.snp.makeConstraints {
          $0.size.equalTo(CGSize(width: 308, height: 170))
          $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
          }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
          }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
          }
    }
    
     func updateUI() {
         titleLabel.text = alertType.title
         descriptionLabel.text = alertType.description
         leftButton.setTitle(alertType.leftButtonTitle, for: .normal)
         rightButton.setTitle(alertType.rightButtonTitle, for: .normal)
    }
}
