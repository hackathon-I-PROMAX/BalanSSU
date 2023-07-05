//
//  VoteViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit

import SnapKit
import Then

final class VoteViewController: BaseViewController {
    
    var categoryId: String?
    var voteChoice: [choicesData] = []
    
    var commentList: Comments? = nil
    // private var userName: [String] = ["Mike", "Joeum", "Cindy", "Bibi", "Javier"]
    // private var departure: [String] = ["전자정보공학부","글로벌미디어학부","컴퓨터학부","컴퓨터학부","미디어 경영"]
    
   init(categoryId: String?) {
       super.init(nibName: nil, bundle: nil)
       self.categoryId = categoryId
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backButton = BackButton(type: .system)
    private var voteView = VoteView()
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
        label.text = "0개"
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
    private lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: ImageLiterals.navigationBarBackButton, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()
    private lazy var scrapBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "heart"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()
    
    @objc func backBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func commentEroll() {
        print("댓글 등록")
        var commentText: String = ""
        commentText = commentField.text ?? "error"
        commentField.resignFirstResponder() //텍스트필드 비활성화
        commentField.text = ""
//        comment.append(commentText)
//        userName.append("Joni")
//        departure.append("글로벌미디어학부")
        //commentCount.text = comment.count()
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
    
    @objc func voteButtonTapped() {
        var choiceID: String = ""
        guard let categoryId = self.categoryId else { return }
        
        if voteView.optionA.isSelected || voteView.optionB.isSelected {
            if voteView.optionA.isSelected {
                choiceID = self.voteChoice[0].choiceId
            } else if voteView.optionB.isSelected {
                choiceID = self.voteChoice[1].choiceId
            }
            voteView.makeVoteViewTypeView(status: .vote)
            postChoices(categoryId: categoryId, choiceId: choiceID) { [weak self] result in
                if result.choices[0].count > result.choices[1].count {
                    self?.voteView.optionA.optionButton.makeActiveTypeButton(status: .voteActive)
                    self?.voteView.optionB.optionButton.makeActiveTypeButton(status: .nonVoteActive)
                } else {
                    self?.voteView.optionB.optionButton.makeActiveTypeButton(status: .voteActive)
                    self?.voteView.optionA.optionButton.makeActiveTypeButton(status: .nonVoteActive)
                }
                self?.voteView.optionA.optionLabel.text = "\(result.choices[0].count)%"
                self?.voteView.optionB.optionLabel.text = "\(result.choices[1].count)%"
            }
        }
    }
    
    // 화면 터치하면 keyboard 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
        
    private func setAddTaget() {
        voteView.voteButton.addTarget(self, action: #selector(voteButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = backBarButton
        self.navigationItem.rightBarButtonItem = scrapBarButton
        setAddTaget()
        getComment(categoryId ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVoteView(categoryId ?? "")
        getComment(categoryId ?? "")
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
    
    override func setConstraints() {
        voteView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(345)
        }
        
        commentIcon.snp.makeConstraints {
            //$0.bottom.equalTo(container.snp.top).offset(-23)
            $0.leading.equalToSuperview().inset(28)
            $0.width.height.equalTo(18)
            $0.top.equalTo(voteView.snp.bottom).offset(33)
        }
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(voteView.snp.bottom).offset(29)
            //$0.bottom.equalTo(container.snp.top).offset(-22)
            $0.leading.equalTo(commentIcon.snp.leading).inset(25)
        }
        commentCount.snp.makeConstraints {
            $0.top.equalTo(voteView.snp.bottom).offset(30)
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
    
    override func setViewHierarchy() {
        view.addSubview(voteView)

        self.view.addSubview(commentIcon)
        self.view.addSubview(commentLabel)
        // commentCount.text = "\(commentList.count)개"
        self.view.addSubview(commentCount)
        self.view.addSubview(container)
        container.addSubview(commentField)
        self.commentField.rightView = commentButton
        self.commentField.rightViewMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(tableView)
    }
    
    override func configUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset.left = 20
        tableView.separatorInset.right = 20
        commentField.delegate = self
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension VoteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num: Int = commentList?.content.count ?? 0
        if num == 0 {
            tableView.setEmptyMessage("댓글이 아직 없습니다. :)")
            return 0
        }
        tableView.restore()
        return 5// commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let num: Int = commentList?.content.count ?? 0
        commentCount.text = "\(commentList?.totalElements)개"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentListTableViewCell.identifier, for: indexPath) as! CommentListTableViewCell
        // let cardImage = UIImage(named: "\(card[indexPath.row]).png")
        // cell.cardImage.image = cardImage
        cell.img.image = UIImage(named: "profileImage")
        cell.name.text = commentList?.content[(num-1)-indexPath.row].nickname
        cell.badge.text = commentList?.content[(num-1)-indexPath.row].department
        cell.comment.text = commentList?.content[(num-1)-indexPath.row].content
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
    private func getVoteView(_ categoryId: String) {
        NetworkService.shared.voteView.getVoteView(categoryId: categoryId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? VoteViewResponse else { return }
                self?.voteChoice = data.choices
                
                if data.category.isParticipating {
                    self?.voteView.makeVoteViewTypeView(status: .vote)
                    if data.choices[0].count > data.choices[1].count {
                        self?.voteView.optionA.optionButton.makeActiveTypeButton(status: .voteActive)
                        self?.voteView.optionB.optionButton.makeActiveTypeButton(status: .nonVoteActive)
                    } else {
                        self?.voteView.optionB.optionButton.makeActiveTypeButton(status: .voteActive)
                        self?.voteView.optionA.optionButton.makeActiveTypeButton(status: .nonVoteActive)
                    }
                }
                self?.voteView.topicLabel.text = data.category.title
                self?.voteView.joinNumberLabel.text = "현재 \(data.category.participantCount)명 참여중"
                self?.voteView.deadlineLabel.text = "D-\(data.category.dday)"
                self?.voteView.optionA.optionButton.optionTitleLabel.text = data.choices[0].name
                self?.voteView.optionB.optionButton.optionTitleLabel.text = data.choices[1].name
                
                self?.voteView.optionA.optionLabel.text = "\(data.choices[0].count)%"
                self?.voteView.optionB.optionLabel.text = "\(data.choices[1].count)%"
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
    
    private func postChoices(categoryId: String, choiceId: String, completion: @escaping (ChoicesResponse) -> Void) {
        NetworkService.shared.choices.postChoices(categoryId: categoryId, choiceId: choiceId) {
            result in
            switch result {
            case .success(let response):
                guard let data = response as? ChoicesResponse else { return }
                completion(data)
            case .requestErr(let error):
                dump(error)
                guard let data = error as? ErrorResponse else { return }
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
    
    //댓글 api
    private func getComment(_ categoryId: String) {
        print("getComment")
        NetworkService.shared.comment.getComment(categoryId: categoryId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? CommentResponse else { return }
                self?.commentList = data.comments
                
                // print("==== comment Test2: \(String(describing: self?.commentList?.content[0]))")
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

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.font = UIFont(name: "AppleSDGothicNeoR00", size: 14.0)
            label.textColor = .lightGray
            label.numberOfLines = 0;
            label.textAlignment = .center;
            return label
        }()
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}


