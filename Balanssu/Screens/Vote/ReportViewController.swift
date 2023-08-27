//
//  ReportViewController.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/08/26.
//

import UIKit
import SnapKit
import Then

class ReportViewController: BaseViewController, UITextFieldDelegate {
    let reportArr = ["광고/음란성 댓글", "욕설/반말/부적절한 언어", "회원 분란 유도", "회원 비방", "도배성 댓글", "기타"]
    var categoryId: String?
    var commentId: String?
    var type: String?
    var selectedButton: UIButton?
    var emailFilled = false
    
    init(categoryId: String?, commentId: String?) {
        super.init(nibName: nil, bundle: nil)
        self.categoryId = categoryId
        self.commentId = commentId
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let alertView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    private let reportTitleLabel = UILabel().then {
        $0.text = "신고하기"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 18.0)
    }
    
    private let reportImageView = UIImageView().then {
        $0.image = ImageLiterals.reportLabel
    }
    
    private let reportContentLabel = UILabel().then {
        $0.text = "신고사유"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 16.0)
    }
    
    private let reportTableView = UITableView().then {
        $0.backgroundColor = .yellow
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    private let reportTextView = UITextView().then {
        $0.text = " 기타 사유를 입력해 주세요."
        $0.textColor = UIColor.customColor(.reportPlaceholder)
        $0.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 2
        $0.layer.borderColor = UIColor.customColor(.reportPlaceholder).cgColor
    }
    
    private let reportEmailImageView = UIImageView().then {
        $0.image = ImageLiterals.reportLabel
    }
    
    private let reportEmailLabel = UILabel().then {
        $0.text = "이메일"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 16.0)
    }
    
    private let reportEmailTextField = UITextField().then {
        $0.placeholder = "신고 접수 이메일을 입력해 주세요."
        $0.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        $0.textColor = .black
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        $0.leftViewMode = .always
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 2
        $0.layer.borderColor = UIColor.customColor(.reportPlaceholder).cgColor
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        if let text = reportEmailTextField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            emailFilled = true
        } else {
            emailFilled = false
        }
    }
    
    private let reportAgreeButton = UIButton().then {
        $0.isSelected = false
        $0.setImage(ImageLiterals.reportButtonDefault, for: .normal)
        $0.addTarget(self, action: #selector(reportCheckButtonTapped), for: .touchUpInside)
    }
    
    @objc func reportCheckButtonTapped() {
        reportAgreeButton.isSelected.toggle()
        reportAgreeButton.setImage(ImageLiterals.reportButtonCheck, for: .selected)
    }
    
    private let reportAgreeLabel = UILabel().then {
        $0.text = "개인정보 수집 및 이용 동의"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 14.0)
    }
    
    private let reportAgreeContentLabel = UILabel().then {
        $0.text = "신고 처리 및 절차 고지를 위해 이메일을 수집하고 있으며, 신고가 처리된 후 수집된 이메일은 즉시 파기됩니다. 동의를 거부한 경우 신고 처리 절차 현황을 고지받을 수 없습니다."
        $0.textColor = UIColor.customColor(.reportGray)
        $0.numberOfLines = 0
        $0.font = UIFont(name: "AppleSDGothicNeoR00", size: 10.0)
    }
    
    private let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped(_ cancelButton: UIButton) {
        self.dismiss(animated: false)
    }
    
    @objc func reportButtonTapped(_ reportButton: UIButton) {
        if reportAgreeButton.isSelected == true && emailFilled == true && selectedButton != nil {
            postReport(categoryId ?? "categoryId error", commentId ?? "commentId error", reportTextView.text ?? "content error", reportEmailTextField.text ?? "email error", type ?? "type error") { _ in
                print("댓글 신고 성공")
            }
            print(categoryId)
            print(commentId)
            print(reportTextView.text)
            print(reportEmailTextField.text)
            print(type)
            self.dismiss(animated: false)
        }
    }
    
    func postReport(_ categoryId: String, _ commentId: String, _ content: String, _ email: String, _ type: String,
                    completion: @escaping (BlankDataResponse) -> Void) {
        NetworkService.shared.report.postReport(categoryId: categoryId, commentId: commentId, content: content, email: email, type: type) { result in
            print("댓글 신고 \(result)")
            switch result {
            case .success(let response):
                guard let data = response as? BlankDataResponse else { return }
                completion(data)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
    
    private let reportButton = UIButton().then {
        $0.setTitle("신고하기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        $0.backgroundColor = UIColor.customColor(.defaultBlue)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
    }
    
    private let buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextView(_:)))
    
    @objc func didTapTextView(_ sender: Any) {
        alertView.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
        self.setViewHierarchy()
        self.view.backgroundColor = .clear
        
        self.reportTableView.dataSource = self
        self.reportTableView.delegate = self
        self.reportTableView.register(ReportTableViewCell.self, forCellReuseIdentifier: ReportTableViewCell.identifier)
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        
        self.alertView.addGestureRecognizer(tapGesture)
        self.reportTextView.delegate = self
        self.reportEmailTextField.delegate = self
    }

    override func setViewHierarchy() {
        self.view.addSubview(alertView)
        [self.reportTitleLabel, self.reportTableView, self.reportContentLabel, self.reportImageView, self.reportTextView, self.reportEmailImageView, self.reportEmailLabel, self.reportEmailTextField, self.reportAgreeButton, self.reportAgreeLabel, self.reportAgreeContentLabel, self.buttonStackView]
            .forEach { self.alertView.addSubview($0) }
        self.buttonStackView.addArrangedSubviews(cancelButton, reportButton)
    }

    override func setConstraints() {
        self.alertView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
        }
        
        self.reportTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        self.reportImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalTo(reportContentLabel.snp.centerY)
            $0.width.height.equalTo(12)
        }
        
        self.reportContentLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(62)
            $0.leading.equalTo(reportImageView.snp.trailing)
        }
        
        self.reportTableView.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(89)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(180)
        }
        
        self.reportTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(reportTableView.snp.bottom).offset(8)
            $0.bottom.equalTo(reportEmailImageView.snp.top).offset(-36)
        }
        
        self.reportEmailImageView.snp.makeConstraints {
            $0.leading.equalTo(alertView).inset(24)
            $0.bottom.equalTo(alertView).offset(-245)
            $0.width.height.equalTo(12)
        }
        
        self.reportEmailLabel.snp.makeConstraints {
            $0.leading.equalTo(reportEmailImageView.snp.trailing)
            $0.centerY.equalTo(reportEmailImageView.snp.centerY)
        }
        
        self.reportEmailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(alertView).offset(-190)
            $0.height.equalTo(40)
        }
        
        self.reportAgreeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.bottom.equalTo(alertView).offset(-145)
            $0.width.height.equalTo(20)
        }
        
        self.reportAgreeLabel.snp.makeConstraints {
            $0.leading.equalTo(reportAgreeButton.snp.trailing).offset(5)
            $0.centerY.equalTo(reportAgreeButton.snp.centerY)
        }
        
        self.reportAgreeContentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(reportAgreeLabel.snp.bottom).offset(4)
        }
        
        self.buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(alertView).offset(-24)
            $0.height.equalTo(42)
        }
        
        self.cancelButton.snp.makeConstraints {
            $0.leading.top.bottom.equalTo(self.buttonStackView)
        }
        
        self.reportButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalTo(self.buttonStackView)
        }
    }
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reportTableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.identifier, for: indexPath) as? ReportTableViewCell else { return UITableViewCell() }
        cell.contentLabel.text = reportArr[indexPath.row]
        cell.checkButton.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
        cell.selectionStyle = .none

        return cell
    }

    @objc func checkButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? ReportTableViewCell,
              let indexPath = reportTableView.indexPath(for: cell) else {
            return
        }
        
        cell.checkButton.isSelected.toggle()
        cell.checkButton.setImage(ImageLiterals.reportCheck, for: .selected)
        cell.checkButton.setImage(ImageLiterals.reportDefault, for: .normal)

        if let previousButton = selectedButton {
            previousButton.isSelected = false
        }
        
        if selectedButton == sender {
            selectedButton = nil
        } else {
            selectedButton = sender
            selectedButton?.isSelected = true
        }
        
        self.type = cell.contentLabel.text
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reportTextView.text == " 기타 사유를 입력해 주세요." {
            reportTextView.text = nil
            reportTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if reportTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            reportTextView.text = " 기타 사유를 입력해 주세요."
            reportTextView.textColor = UIColor.customColor(.reportPlaceholder)
        }
    }
}
