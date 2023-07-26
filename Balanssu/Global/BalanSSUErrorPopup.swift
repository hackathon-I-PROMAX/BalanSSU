//
//  BalanSSUErrorPopup.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/15.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class BalanSSUErrorPopup: UIViewController {
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.backgroundColor = .white
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
    
    lazy var button: UIButton = {
        let v = UIButton()
        v.setTitleColor(.black, for: .normal)
        v.titleLabel?.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        return v
    }()
    
    private let disposeBag: DisposeBag = .init()
    private var buttonAction: ButtonAction?
    private var alertType: ErrorAlertType
    
    init(alertType: ErrorAlertType) {
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

        button.rx.tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { owner, _ in
                owner.buttonAction?()
                owner.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    
    func errorPresent(
        on viewController: UIViewController,
        alertType: ErrorAlertType,
        buttonAction: ButtonAction? = nil
    ) {
        self.buttonAction = buttonAction

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
        contentView.addSubview(button)
                
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
        
        button.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
          }
    }
    
     func updateUI() {
         titleLabel.text = alertType.title
         descriptionLabel.text = alertType.description
         button.setTitle(alertType.buttonTitle, for: .normal)
    }
}

