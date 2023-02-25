//
//  VoteViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import SnapKit
import Then

class VoteViewController: BaseViewController {
   var categoryId: String?

   init(categoryId: String?) {
       super.init(nibName: nil, bundle: nil)
       self.categoryId = categoryId
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var voteViewTitle: String = "123"
    var voteChoice: [choicesData] = []
    //MARK: - Bibi
    let testView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
        $0.layer.cornerRadius = 12
    }
    
    let topicLabel = UILabel().then {
        $0.text = "술 먹고 다음날 일어났더니?"
        $0.textColor = .black
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 20)
    }
    
    let joinNumberLabel = UILabel().then {
        $0.text = "현재 100명 참여중"
        $0.textColor = UIColor(r: 125, g: 125, b: 125)
        $0.font = UIFont(name: "AppleSDGothicNeoM00", size: 12)
    }
    
    let deadlineImageView = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(r: 226, g: 231, b: 240)
    }
    
    let deadlineLabel = UILabel().then {
        $0.text = "D-3"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 14)
    }
    
    let stackAView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .top
        $0.distribution = .fill
        $0.spacing = 2
    }
    
    let stackBView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .top
        $0.distribution = .fill
        $0.spacing = 2
    }
    
    let optionAButton = UIButton().then {
        $0.setTitle("전 애인한테 부재중 발신 21건", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoL00", size: 15)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .leading
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignTextLeft(spacing: 38)
        $0.addTarget(self, action: #selector(optionAButtonTapped), for: .touchUpInside)
    }
    
    let optionBButton = UIButton().then {
        $0.setTitle("전공교수님과 통화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoL00", size: 15)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 223, g: 223, b: 223).cgColor
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .leading
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignTextLeft(spacing: 38)
        $0.addTarget(self, action: #selector(optionBButtonTapped), for: .touchUpInside)
    }
    
    let optionALabel = UILabel().then {
        $0.text = "36%"
        $0.textColor = UIColor(r: 209, g: 209, b: 209)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 24)
        $0.textAlignment = .right
    }
    
    let optionBLabel = UILabel().then {
        $0.text = "64%"
        $0.textColor = UIColor(r: 64, g: 96, b: 160)
        $0.font = UIFont(name: "AppleSDGothicNeoB00", size: 24)
        $0.textAlignment = .right
    }
    
    let optionAImageView = UIImageView().then {
        $0.image = UIImage(named: "UnselectedOption")
    }
    
    let optionBImageView = UIImageView().then {
        $0.image = UIImage(named: "UnselectedOption")
    }
    
    let logoIconImageView = UIImageView().then {
        $0.image = UIImage(named: "logo.small")
    }
    
    let voteButton = UIButton().then {
        $0.setTitle("투표하기", for: .normal)
        $0.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeoM00", size: 16)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(r: 64, g: 96, b: 160).cgColor
        $0.addTarget(self, action: #selector(voteButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Joni
    let backButton = BackButton(type: .system)
    
    let commentIcon : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "coolicon")
        view.backgroundColor = nil
        return view
    }()
    let commentLabel : UILabel = {
        let label = UILabel()
        label.text = "댓글"
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 18.0)
        label.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        return label
    }()
    let commentCount : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 18.0)
        label.textColor = .black
        return label
    }()
    
    private let tableView : UITableView = { // 테이블 뷰 생성
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentListTableViewCell.self, forCellReuseIdentifier: CommentListTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        return tableView
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let commentField : UITextField = {
        let field = UITextField()
        field.placeholder = "댓글을 입력하세요."
        return field
    }()
    
    private let commentButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.frame = CGRectMake(0, 0, 40, 40)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(commentEroll), for: .touchUpInside)
        button.tintColor = .gray
        return button
    }()
    var comment: [String] = ["안녕하세요. 밸런슈입니다 :)", "댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.댓글입니다.","엘레벌레 해커톤 아주 재밌네요호호호호호호호호호호호호호호호호호호호", "다들 곧 개강 파이팅 해봅시다!!! 아자아자!!! 으랏차차!!!", "밸런슈 최고", "저는 지금 성수동 레이더 카페입니다."]
    
    lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: ImageLiterals.navigationBarBackButton, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()
    
    //MARK: - Bibi
    lazy var scrapBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "heart"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()
    
    @objc func backBarButtonTapped() {
        print("tapped")
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: -Bibi objc
    @objc func voteButtonTapped() {
        if optionAButton.backgroundColor != .white ||
            optionBButton.backgroundColor != .white {
            voteButton.isEnabled = false
            voteButton.setTitle("이미 투표했어요", for: .normal)
            voteButton.setTitleColor(UIColor(r: 150, g: 150, b: 150), for: .normal)
            voteButton.backgroundColor = UIColor(r: 240, g: 240, b: 240)
            voteButton.layer.borderWidth = 0
            
            optionAButton.isEnabled = false
            optionBButton.isEnabled = false
            
            // if choose A
            if optionBButton.backgroundColor == .white {
                optionAButton.setTitleColor(.white, for: .normal)
                optionAButton.backgroundColor = UIColor(r: 64, g: 96, b: 160)
                optionAButton.layer.borderWidth = 0
                
                optionBButton.setTitleColor(UIColor(r: 150, g: 150, b: 150), for: .normal)
                optionBButton.backgroundColor = UIColor(r: 240, g: 240, b: 240)
                optionBButton.layer.borderWidth = 0
                
                optionAImageView.image = UIImage(named: "SelectedOptionResult")
                optionAImageView.tintColor = .white
                
                optionBImageView.isHidden = true
                
                optionALabel.isHidden = false
                optionBLabel.isHidden = false
                
                optionALabel.textColor = UIColor(r: 64, g: 96, b: 160)
                optionBLabel.textColor = UIColor(r: 209, g: 209, b: 209)
            }
            
            // if B choose
            if optionAButton.backgroundColor == .white {
                optionAButton.setTitleColor(UIColor(r: 150, g: 150, b: 150), for: .normal)
                optionAButton.backgroundColor = UIColor(r: 240, g: 240, b: 240)
                optionAButton.layer.borderWidth = 0
                
                optionBButton.setTitleColor(.white, for: .normal)
                optionBButton.backgroundColor = UIColor(r: 64, g: 96, b: 160)
                optionBButton.layer.borderWidth = 0
                
                optionBImageView.image = UIImage(named: "SelectedOptionResult")
                optionBImageView.tintColor = .white
                
                optionAImageView.isHidden = true
                
                optionALabel.isHidden = false
                optionBLabel.isHidden = false
                
                optionALabel.textColor = UIColor(r: 209, g: 209, b: 209)
                optionBLabel.textColor = UIColor(r: 64, g: 96, b: 160)
            }
        }
    }
    
    @objc func optionAButtonTapped() {
        optionAButton.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        optionAButton.backgroundColor = UIColor(r: 226, g: 231, b: 240)
        optionAButton.layer.borderWidth = 0
        optionAImageView.image = UIImage(named: "SelectedOption")

        
        optionBButton.setTitleColor(.black, for: .normal)
        optionBButton.backgroundColor = .white
        optionBButton.layer.borderWidth = 1
        optionBImageView.image = UIImage(named: "UnselectedOption")

    }
    
    @objc func optionBButtonTapped() {
        optionAButton.setTitleColor(.black, for: .normal)
        optionAButton.backgroundColor = .white
        optionAButton.layer.borderWidth = 1
        optionAImageView.image = UIImage(named: "UnselectedOption")

        optionBButton.setTitleColor(UIColor(r: 64, g: 96, b: 160), for: .normal)
        optionBButton.backgroundColor = UIColor(r: 226, g: 231, b: 240)
        optionBButton.layer.borderWidth = 0
        optionBImageView.image = UIImage(named: "SelectedOption")
    }
    
    @objc func commentEroll() {
        print("댓글 등록")
        var commentText: String = ""
        commentText = commentField.text ?? "error"
        commentField.resignFirstResponder() //텍스트필드 비활성화
        commentField.text = ""
        comment.append(commentText)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
         // 키보드가 생성될 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            print("keyboardWillShow" )
            if self.view.frame.origin.y == 0.0 {
                self.view.frame.origin.y -= keyboardHeight-190
            }
       }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        // 키보드가 사라질 때
        self.view.frame.origin.y = 0
    }
    
    // 화면 터치하면 keyboard 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    override func setViewHierarchy() {
        view.addSubview(testView)
        view.addSubview(stackAView)
        view.addSubview(stackBView)
        testView.addSubview(topicLabel)
        testView.addSubview(joinNumberLabel)
        testView.addSubview(deadlineImageView)
        testView.addSubview(deadlineLabel)
        testView.addSubview(voteButton)
        testView.addSubview(logoIconImageView)
        stackAView.addArrangedSubview(optionAButton)
        stackAView.addArrangedSubview(optionALabel)
        stackBView.addArrangedSubview(optionBButton)
        stackBView.addArrangedSubview(optionBLabel)
        optionAButton.addSubview(optionAImageView)
        optionBButton.addSubview(optionBImageView)
        // ====
        self.view.addSubview(commentIcon)
        self.view.addSubview(commentLabel)
        self.view.addSubview(commentCount)
        self.view.addSubview(container)
        container.addSubview(commentField)
        self.commentField.rightView = commentButton
        self.commentField.rightViewMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(tableView)

    }
    
    override func setConstraints() {
        testView.snp.makeConstraints {
            $0.top.equalTo(view).offset(104)
            $0.leading.equalTo(view).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
            $0.height.equalTo(344)
        }
        
        topicLabel.snp.makeConstraints {
            $0.top.equalTo(testView).offset(24)
            $0.leading.equalTo(testView).inset(16)
        }

        joinNumberLabel.snp.makeConstraints {
            $0.top.equalTo(testView).offset(56)
            $0.leading.equalTo(testView).inset(16)
        }
        
        deadlineImageView.snp.makeConstraints {
            $0.top.equalTo(testView).offset(20)
            $0.trailing.equalTo(testView).inset(16)
            $0.height.width.equalTo(35)
        }
        
        deadlineLabel.snp.makeConstraints {
            $0.top.equalTo(testView).offset(28)
            $0.trailing.equalTo(testView).inset(22.5)
        }

        voteButton.snp.makeConstraints {
            $0.top.equalTo(testView).offset(279)
            $0.leading.equalTo(testView).inset(16)
            $0.width.equalTo(250)
            $0.height.equalTo(47)
        }
        
        logoIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(voteButton)
            $0.trailing.equalTo(testView).inset(16)
            $0.height.width.equalTo(41)
        }
        
        stackAView.snp.makeConstraints {
            $0.top.equalTo(testView).offset(83)
            $0.leading.trailing.equalTo(testView).inset(16)
            $0.height.equalTo(85)
            //$0.width.equalTo(100)
        }
        
        optionAButton.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        optionAImageView.snp.makeConstraints {
            $0.centerY.equalTo(optionAButton)
            $0.trailing.equalTo(optionAButton).inset(20)
            $0.height.width.equalTo(28)
        }
        
        optionALabel.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalTo(stackAView).inset(0)
            $0.width.equalTo(70)
        }
        
        stackBView.snp.makeConstraints {
            $0.top.equalTo(testView).offset(180)
            $0.leading.trailing.equalTo(testView).inset(16)
            $0.height.equalTo(85)
        }
        
        optionBButton.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        optionBImageView.snp.makeConstraints {
            $0.centerY.equalTo(optionBButton)
            $0.trailing.equalTo(optionBButton).inset(20)
            $0.height.width.equalTo(28)
        }
        
        optionBLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalTo(stackBView).inset(0)
            $0.width.equalTo(70)
        }
        
        //====
        commentIcon.snp.makeConstraints {
            //$0.bottom.equalTo(container.snp.top).offset(-23)
            $0.leading.equalToSuperview().inset(28)
            $0.width.height.equalTo(18)
            $0.top.equalTo(testView.snp.bottom).offset(33)
        }
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(testView.snp.bottom).offset(29)
            //$0.bottom.equalTo(container.snp.top).offset(-22)
            $0.leading.equalTo(commentIcon.snp.leading).inset(25)
        }
        commentCount.snp.makeConstraints {
            $0.top.equalTo(testView.snp.bottom).offset(30)
            //$0.bottom.equalTo(container.snp.top).offset(-22)
            $0.leading.equalTo(commentLabel.snp.trailing).offset(4)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(10)
            //$0.bottom.equalTo(tableView.snp.top).offset(0)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        commentField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(3)
        }
        
        tableView.snp.makeConstraints {
            //$0.height.equalTo(198)
            $0.top.equalTo(container.snp.bottom).offset(3)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            //$0.bottom.equalToSuperview()
        }
        
        
    }
    
    func setLayouts() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset.left = 20
        tableView.separatorInset.right = 20
        commentField.delegate = self
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVoteView(categoryId ?? "")
        print(voteViewTitle)
        //self.optionAButton.setTitle(voteChoice[0].name, for: .normal)
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = backBarButton
        self.commentCount.text = "\(comment.count)개"
        self.navigationItem.rightBarButtonItem = scrapBarButton
        optionALabel.isHidden = true
        optionBLabel.isHidden = true

        setLayouts()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
}

extension VoteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentListTableViewCell.identifier, for: indexPath) as! CommentListTableViewCell
        // let cardImage = UIImage(named: "\(card[indexPath.row]).png")
        // cell.cardImage.image = cardImage
        cell.img.image = UIImage(named: "ppussung")
        cell.name.text = "뿌슝이"
        cell.badge.text = "글로벌미디어학부"
        cell.comment.text = comment[((comment.count)-1)-indexPath.row]
        return cell
    }

}

extension VoteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}

extension VoteViewController : UITextFieldDelegate {

}

extension VoteViewController {
    func getVoteView(_ categoryId: String) {
        NetworkService.shared.voteView.getVoteView(categoryId: categoryId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? VoteViewResponse else { return }
                self?.voteViewTitle = data.category.title
                self?.voteChoice = data.choices
                print("==== VoteListArr Test: \(String(describing: self?.voteViewTitle))")
                print("==== VoteListArr Test: \(String(describing: self?.voteChoice[0]))")
                self?.topicLabel.text = data.category.title
                self?.joinNumberLabel.text = "현재 \(data.category.participantCount)명 참여중"
                self?.deadlineLabel.text = "D-\(data.category.dday)"
                self?.optionAButton.setTitle(data.choices[0].name, for: .normal)
                self?.optionBButton.setTitle(data.choices[1].name, for: .normal)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data.message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
