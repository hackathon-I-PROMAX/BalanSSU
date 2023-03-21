//
//  SignUp2ViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import Foundation
import UIKit
import SnapKit
import Moya

class SignUp2ViewController: BaseViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var username: String?
    var password: String?
 
    init(username: String?, password: String?) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.password = password
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nickNameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let genderLabel = UILabel().then {
        $0.text = "성별"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let gender = ["M", "F"]
    let grade = ["23", "22", "21", "20", "19", "18", "17", "16", "15"]
    let major = ["기독교학과", "국어국문학과", "영어영문학과", "독어독문학과", "불어불문학과",
                 "중어중문학과", "일어일문학과", "철학과", "사학과", "예술창작학부 문예창작전공",
                 "예술창작학부 영화예술전공", "스포츠 학부", "수학과", "물리학과",
                 "화학과", "정보통계보험수리학과", "의생명시스템학부", "법학과",
                 "국제법무학과", "화학공학과", "유기신소재파이버공학과", "전기공학부",
                 "기계공학부", "산업정보시스템공학과", "건축학부", "경제학과",
                 "글로벌통상학과", "사회복지학부", "행정학부", "정치외교학과",
                 "정보사회학과", "언론홍보학과", "평생교육학과", "경영학부",
                 "회계학과", "벤처중소기업학과", "금융학부", "벤처경영학과",
                 "혁신경영학과", "복지경영학과", "회계세무학과", "컴퓨터학부",
                 "전자정보공학부 전자공학전공", "전자정보공학부 IT융합전공",
                 "글로벌미디어학부", "소프트웨어학부", "AI 융합학부",
                 "미디어경영학과", "융합특성화 자유전공학부","차세대반도체학과건축학부"]
    
    func createGenderPickerView() {
        let genderPickerView = UIPickerView()
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        genderTextField.inputView = genderPickerView
        genderPickerView.tag = 1
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
                
        genderTextField.inputAccessoryView = toolBar
    }
    
    func createGradePickerView() {
        let gradePickerView = UIPickerView()
        gradePickerView.dataSource = self
        gradePickerView.delegate = self
        gradeTextField.inputView = gradePickerView
        gradePickerView.tag = 2
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
                
        gradeTextField.inputAccessoryView = toolBar
    }
    
    func createMajorPickerView() {
        let majorPickerView = UIPickerView()
        majorPickerView.dataSource = self
        majorPickerView.delegate = self
        majorTextField.inputView = majorPickerView
        majorPickerView.tag = 3
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
                
        majorTextField.inputAccessoryView = toolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return gender.count
        case 2:
            return grade.count
        case 3:
            return major.count
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return gender[row]
        case 2:
            return grade[row]
        case 3:
            return major[row]
        default:
            return "Data not found"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            return genderTextField.text = gender[row]
        case 2:
            return gradeTextField.text = grade[row]
        case 3:
            return majorTextField.text = major[row]
        default:
            return
        }
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
    
    @objc func onPickDone() {
        genderTextField.resignFirstResponder()
        gradeTextField.resignFirstResponder()
        majorTextField.resignFirstResponder()
    }
    
    @objc func onPickCancel() {
        genderTextField.resignFirstResponder()
        gradeTextField.resignFirstResponder()
        majorTextField.resignFirstResponder()
    }
    
    let gradeLabel = UILabel().then {
        $0.text = "학번"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let majorLabel = UILabel().then {
        $0.text = "학부"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let nickNameTextField = UITextField().then {
        $0.placeholder = "3자 이상의 닉네임을 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }
    
    let genderTextField = UITextField().then {
        $0.placeholder = "성별을 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.tintColor = .clear
        $0.addLeftPadding()
    }
    
    let gradeTextField = UITextField().then {
        $0.placeholder = "학번을 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.tintColor = .clear
        $0.addLeftPadding()
    }
    
    let majorTextField = UITextField().then {
        $0.placeholder = "학부를 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.tintColor = .clear
        $0.addLeftPadding()
    }
    
    let checkNickNameLabel = UILabel().then {
        $0.text = "이미 사용중인 닉네임입니다"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let nickNameImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return false
        }
    
    let checkButton = UIButton().then {
        $0.isEnabled = true
//        $0.isEnabled = false
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
        @objc func checkButtonTapped() {
        
            if self.checkButton.isEnabled {
                signUp()
                makeSignUpAlert()
            }
            
    }
    
    func signUp() {
        
        guard let username = self.username else { return }
        guard let password = self.password else { return }
        guard let nickname = self.nickNameTextField.text else { return }
        guard let schoolAge = self.gradeTextField.text else { return }
        guard let departure = self.majorTextField.text else { return }
        guard let gender = self.genderTextField.text else { return }
        
        postSignUp(username: username, password: password, nickname: nickname, schoolAge: schoolAge, departure: departure, gender: gender) { _ in
            print("회원가입 성공")
        }
    }
    
    func makeSignUpAlert() {
        let loginAlert = UIAlertController(title: "🎉회원가입 완료🎉", message: "이제 즐겁게 밸런슈를 즐기세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeStartView()
            }
        }
        loginAlert.addAction(okAction)
        self.present(loginAlert, animated: true)
    }
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        if self.nickNameTextField.text?.isEmpty == false
        {
            self.checkNickNameLabel.textColor = UIColor(r: 64, g: 96, b: 160)
        } else {
            self.checkNickNameLabel.textColor = .white
        }
        
        if self.nickNameTextField.text!.count > 2
        {
            nickNameImageView.image = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
            nickNameImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
            //            checkButton.isEnabled = true
        }
        else {
            nickNameImageView.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
            nickNameImageView.tintColor = UIColor(r: 64, g: 96, b: 160)
            //            checkButton.isEnabled = false
        }
        
        if self.nickNameTextField.text?.isEmpty == false
            && self.genderTextField.text == ""
            && self.gradeTextField.text == ""
            && self.majorTextField.text == ""
        {
            checkButton.isEnabled = true
            checkButton.setTitleColor(.white, for: .normal)
            checkButton.backgroundColor = UIColor(r: 64, g: 96, b: 160)
            checkButton.layer.borderWidth = 0
            checkButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        } else {
            checkButton.isEnabled = false
            checkButton.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
            checkButton.backgroundColor = .white
            checkButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
            checkButton.layer.borderWidth = 1
            checkButton.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        }
    }
    
    func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nickNameTextField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        createGenderPickerView()
        createGradePickerView()
        createMajorPickerView()
        genderTextField.delegate = self
        gradeTextField.delegate = self
        majorTextField.delegate = self
        self.nickNameTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        self.genderTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .valueChanged)
        self.gradeTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .valueChanged)
        self.majorTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .valueChanged)
        self.navigationItem.leftBarButtonItem = backBarButton
        navigationItem.title = "회원가입"
        
        print("username: \(username!), password: \(password!)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setViewHierarchy() {
        view.addSubview(nickNameLabel)
        view.addSubview(genderLabel)
        view.addSubview(gradeLabel)
        view.addSubview(majorLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(genderTextField)
        view.addSubview(gradeTextField)
//        view.addSubview(gradeButton)
        view.addSubview(majorTextField)
        view.addSubview(checkButton)
        view.addSubview(checkNickNameLabel)
        view.addSubview(nickNameImageView)
    }
    
    override func setConstraints() {
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(124)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(239)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(334)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(429)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(147)
            $0.leading.equalTo(view).inset(20)
            $0.trailing.equalTo(view).inset(50)
            $0.height.equalTo(48)
        }
        
        genderTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(262)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        gradeTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(357)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        majorTextField.snp.makeConstraints {
            $0.top.equalTo(view).offset(452)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        
        checkNickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(199)
            $0.leading.trailing.equalTo(view).inset(28)
        }
        
        nickNameImageView.snp.makeConstraints {
            $0.top.equalTo(view).offset(161)
            $0.trailing.equalTo(view).offset(-22)
            $0.height.width.equalTo(20)
        }
                
        checkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-54)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
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


extension SignUp2ViewController {
     func postSignUp(username: String,
                    password: String,
                               nickname: String,
                               schoolAge: String,
                               departure: String,
                               gender: String,
                               completion: @escaping (BlankDataResponse) -> Void) {
        NetworkService.shared.auth.postSignUp(username: username, password: password, nickname: nickname, schoolAge: schoolAge, departure: departure, gender: gender) { result in
            
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
}
    
