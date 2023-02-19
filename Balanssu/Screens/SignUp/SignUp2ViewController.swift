//
//  SignUp2ViewController.swift
//  Balanssu
//
//  Created by Bibi on 2023/02/18.
//

import UIKit
import SnapKit

class SignUp2ViewController: BaseViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
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
    
    let gender = ["여자", "남자"]
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return gender.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return gender[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        genderTextField.text = gender[row]
//    }
    
    func createGenderPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTextField.tintColor = .clear
        genderTextField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func onPickDone() {
//        gradeTextField.text =

        gradeTextField.resignFirstResponder()
    }
    
    @objc func onPickCancel() {
        gradeTextField.resignFirstResponder()
    }
    
    let gradeLabel = UILabel().then {
        $0.text = "학번"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let grade = ["23", "22", "21", "20", "19", "18", "17", "16", "15"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grade.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return grade[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gradeTextField.text = grade[row]
    }
    
    func createGradePickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        gradeTextField.inputView = pickerView
    }
    
    let majorLabel = UILabel().then {
        $0.text = "학부"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
    }
    
    let nickNameTextField = UITextField().then {
        $0.placeholder = "사용하실 닉네임을 입력해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        if self.nickNameTextField.text?.isEmpty == false
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
    }
    
    let genderTextField = UITextField().then {
        $0.placeholder = "성별을 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }
    
    let gradeTextField = UITextField().then {
        $0.placeholder = "학번을 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }
    
    let majorTextField = UITextField().then {
        $0.placeholder = "학부를 선택해주세요"
        $0.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }
    
    let checkNickNameLabel = UILabel().then {
        $0.text = "이미 사용중인 닉네임입니다"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let nickNameImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 64, g: 96, b: 160)
    }
    
    let checkButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(r: 64, g: 96, b: 160)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    let backBarButton = BackButton(type: .system)
    
    @objc func checkButtonTapped() {
        let loginAlert = UIAlertController(title: "🎉회원가입 완료🎉", message: "이제 즐겁게 밸런슈를 즐기세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        loginAlert.addAction(okAction)
        self.present(loginAlert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()
        createGenderPickerView()
        createGradePickerView()
//        gradeTextField.delegate = self
//        gradeTextField.isUserInteractionEnabled = false
        self.nickNameTextField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)

        navigationItem.title = "회원가입"
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
        
        let backBarButton = makeBarButtonItem(with: backBarButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
}
