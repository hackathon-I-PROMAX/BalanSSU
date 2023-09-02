//
//  VoteViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit

import SnapKit
import Then
import YDS
import JGProgressHUD

final class VoteViewController: BaseViewController {
    
    var categoryId: String?
    var commentId: String?
    var reportCommentID: String?
    var voteChoice: [choicesData] = []
    var reportAvailable: Bool?

    var entireVote: Int = 0
    var voteA: Double = 0
    var voteB: Double = 0

    var commentList: [Content] = []
    var Num = 0
    var page = 0
    var size = 20
    
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
        view.backgroundColor = .white
        return view
    }()
    let maxHeight: CGFloat = 120
    private lazy var commentTextView: YDSTextView = {
        let textView = YDSTextView(maxHeight: maxHeight)
        textView.backgroundColor = YDSColor.inputFieldElevated
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.textContainerInset = .init(top: 12, left: 16, bottom: 12, right: 34)
        textView.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        textView.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        textView.layer.cornerRadius = 8
        textView.placeholder = "댓글을 입력해주세요."
        return textView
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
    
    @objc func backBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func reportButtonTapped(sender: UIButton) {
        self.reportCommentID = commentList[sender.tag].commentID
        getReport(self.categoryId ?? " ", reportCommentID ?? " ")
        print("==== \(sender.tag)")
        print(self.categoryId)
        print(self.commentId)
        print(self.reportAvailable)
    }

    @objc func commentEroll() {
        print("댓글 등록\(commentTextView.text)")
        var commentText: String = ""
        commentText = commentTextView.text ?? "error"
        postComment(categoryId ?? "categoryId error", commentText) { _ in
            print("댓글 작성 성공")
        }
        
        commentTextView.resignFirstResponder() //텍스트필드 비활성화
        commentTextView.text = ""
        commentTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(3)
            $0.height.equalTo(48)
        }
    }
    
    lazy var hud: JGProgressHUD = {
        let loader = JGProgressHUD(style: .dark)
        return loader
    }()
    
    func showLoading() {
            DispatchQueue.main.async {
                self.hud.show(in: self.view, animated: true)
            }
        }

    func hideLoading() {
        DispatchQueue.main.async {
            self.hud.dismiss(animated: true)
        }
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

                if result.choices[0].count == 0 && result.choices[1].count == 0 {
                    self?.voteView.optionA.optionLabel.text = "0%"
                    self?.voteView.optionB.optionLabel.text = "0%"
                } else {
                    self?.entireVote = result.choices[0].count + result.choices[1].count
                    self?.voteA = (Double(result.choices[0].count) / Double(self!.entireVote)) * 100
                    self?.voteB = (Double(result.choices[1].count) / Double(self!.entireVote)) * 100
                    self?.voteView.optionA.optionLabel.text = "\(Int((self!.voteA)))%"
                    self?.voteView.optionB.optionLabel.text = "\(Int((self!.voteB)))%"
                }
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
        self.tableView.reloadData()
        commentTextView.delegate = self
        
        setAddTaget()
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVoteView(categoryId ?? "")
        getComment(categoryId ?? "",page ?? 0,size ?? 0)
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
            $0.leading.equalToSuperview().inset(28)
            $0.width.height.equalTo(18)
            $0.top.equalTo(voteView.snp.bottom).offset(33)
        }
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(voteView.snp.bottom).offset(29)
            $0.leading.equalTo(commentIcon.snp.leading).inset(25)
        }
        commentCount.snp.makeConstraints {
            $0.top.equalTo(voteView.snp.bottom).offset(30)
            $0.leading.equalTo(commentLabel.snp.trailing).offset(4)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        commentTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(3)
            $0.height.equalTo(48)
        }
        commentButton.snp.makeConstraints {
            $0.trailing.equalTo(container.snp.trailing).offset(-10)
            $0.top.equalTo(commentTextView.snp.top).offset(8)
            $0.size.equalTo(30)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(commentTextView.snp.bottom).offset(3)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setViewHierarchy() {
        view.addSubview(voteView)
        
        self.view.addSubview(commentIcon)
        self.view.addSubview(commentLabel)
        self.view.addSubview(commentCount)
        self.view.addSubview(container)
        container.addSubview(commentTextView)
        commentTextView.addSubview(commentButton)
        self.view.addSubview(tableView)
    }
    
    override func configUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset.left = 20
        tableView.separatorInset.right = 20
    }
}

extension VoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            /// 42 이하일때는 더 이상 줄어들지 않게하기
            if estimatedSize.height <= 42 { }
            else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //이전 글자 - 선택된 글자 + 새로운 글자(대체될 글자)
        let newLength = textView.text.count - range.length + text.count
            if newLength > 100 {
              return false
            }
        return true
    }
}

extension VoteViewController : UITableViewDataSource {
    // cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commentList.count == 0 {
            tableView.setEmptyMessage("댓글이 아직 없습니다. :)")
            return 0
        }
        tableView.restore()
        return commentList.count
    }
    // cell 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        commentCount.text = "\(Num)개"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentListTableViewCell.identifier, for: indexPath) as! CommentListTableViewCell
        let comment = commentList[indexPath.row]
        cell.prepareForReuse()

        if (commentList[indexPath.row].isUserDeleted == true) {
            cell.name.text = nil
            //cell.name.textColor = .red
            cell.badge.text = "탈퇴한 사용자"
            cell.badge.backgroundColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 0.2)
            cell.badge.textColor = .darkGray
            
        } else {
            cell.name.text = commentList[indexPath.row].nickname
            cell.badge.text = commentList[indexPath.row].mbti
            cell.badge.backgroundColor = UIColor(red: 0.992, green: 0.969, blue: 0.898, alpha: 1)
            cell.badge.textColor = UIColor(red: 0.746, green: 0.605, blue: 0.183, alpha: 1)
        }
        cell.img.image = UIImage(named: "ppussung")
        cell.commentLabel.text = commentList[indexPath.row].content
        cell.selectionStyle = .none
        cell.reportButton.tag = indexPath.row
        print("== index: \(indexPath.row)")
//        self.commentId = commentList[cell.reportButton.tag].commentID
//        print("== commentID: \(commentId)")
        cell.reportButton.addTarget(self, action: #selector(reportButtonTapped(sender : )), for: .touchUpInside)
        if comment.isOwner == true {
            cell.reportButton.isHidden = true
        }
        return cell
    }
    // swipe delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let comment = commentList[indexPath.row]
            if comment.isOwner {
                commentList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                let commentId: String = comment.commentID
                deleteComment(categoryId ?? "categoryId error", commentId)  { _ in
                    print("댓글 삭제 성공")
                }
                Num -= 1
                commentCount.text = "\(Num)개"
            } else {
                // 1. 알람 인스턴스 생성
                let alert = UIAlertController(title: "댓글 삭제 불가", message: "자신이 작성한 댓글이 아니면 \n 삭제할 수 없습니다.", preferredStyle: .alert)
                // 2. 액션 생성
                let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                    print("수행 할 동작")
                    return
                }
                // 3. 알람에 액션 추가
                alert.addAction(okAction)
                // 4. 화면에 표현
                present(alert, animated: true)
                return
            }
            
        } else if editingStyle == .insert {
            
        }
    }
}

extension VoteViewController : UITableViewDelegate {
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

extension VoteViewController {
    private func getVoteView(_ categoryId: String) {
        NetworkService.shared.voteView.getVoteView(categoryId: categoryId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? VoteViewResponse else { return }
                self?.voteChoice = data.choices
                
                if data.category.dday < 0 {
                    self?.voteView.makeVoteViewTypeView(status: .closed)
                    self?.commentTextView.isEditable = false
                    self?.commentTextView.placeholder = " 투표가 마감되어 댓글을 작성할 수 없습니다."
                    if data.choices[0].count > data.choices[1].count {
                        self?.voteView.optionA.optionButton.makeActiveTypeButton(status: .voteActive)
                        self?.voteView.optionB.optionButton.makeActiveTypeButton(status: .nonVoteActive)
                    } else {
                        self?.voteView.optionB.optionButton.makeActiveTypeButton(status: .nonVoteWin)
                        self?.voteView.optionA.optionButton.makeActiveTypeButton(status: .nonVoteActive)
                    }
                } else {
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
                }
                self?.voteView.topicLabel.text = data.category.title
                if data.category.dday < 0 {
                    self?.voteView.deadlineImageView.image = nil
                    self?.voteView.deadlineLabel.text = nil
                    self?.voteView.joinNumberLabel.text = "\(data.category.participantCount)명 참여"
                } else {
                    self?.voteView.deadlineFinishedImageView.image = nil
                    self?.voteView.deadlineLabel.text = "D-\(data.category.dday)"
                    self?.voteView.joinNumberLabel.text = "현재 \(data.category.participantCount)명 참여중"
                }
                self?.voteView.optionA.optionButton.optionTitleLabel.text = data.choices[0].name
                self?.voteView.optionB.optionButton.optionTitleLabel.text = data.choices[1].name

                if data.choices[0].count == 0 && data.choices[1].count == 0 {
                    self?.voteView.optionA.optionLabel.text = "0%"
                    self?.voteView.optionB.optionLabel.text = "0"
                } else {
                    self?.entireVote = data.choices[0].count + data.choices[1].count
                    self?.voteA = (Double(data.choices[0].count) / Double(self!.entireVote)) * 100
                    self?.voteB = (Double(data.choices[1].count) / Double(self!.entireVote)) * 100
                    self?.voteView.optionA.optionLabel.text = "\(Int((self!.voteA)))%"
                    self?.voteView.optionB.optionLabel.text = "\(Int((self!.voteB)))%"
                }
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
    
    //댓글 정보 (get)
    private func getComment(_ categoryId: String, _ page: Int, _ size: Int) {
        NetworkService.shared.comment.getComment(categoryId: categoryId, page: page, size: size) { [weak self] result in
            switch result {
            case .success(let response):
                print("categortId: \(categoryId)")
                guard let data = response as? CommentResponse else { return }
                self?.commentList = data.comments.content
                self?.tableView.reloadData()
                self?.Num = data.comments.totalElements
                
                print("댓글 가져오기 page: \(page), size: \(size)")
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
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y // frame영역의 origin에 비교했을때의 content view의 현재 origin 위치
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height // 화면에는 frame만큼 가득 찰 수 있기때문에 frame의 height를 빼준 것

        // 스크롤 할 수 있는 영역보다 더 스크롤된 경우 (하단에서 스크롤이 더 된 경우)
        if maximumOffset < currentOffset {
            showLoading() // 데이터 로딩 중 표시
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
//                if (self!.page == 0) {
//                    self!.page += 1
//                }
//                self!.page += 1
                self!.size += 10
                self!.getComment(self?.categoryId ?? "",self?.page ?? 0,self!.size ?? 20)
                self?.hideLoading()
            }
        }
    }
    // 댓글 작성 (post)
    func postComment(_ categoryId: String,_ content: String,
                     completion: @escaping (BlankDataResponse) -> Void) {
        NetworkService.shared.comment.postComment(categoryId: categoryId, content: content) { result in
            print("댓글 작성 \(result)")
            switch result {
            case .success(let response):
                self.getComment(categoryId,self.page,self.size)
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
    // 댓글 삭제 (delete)
    func deleteComment(_ categoryId: String,_ commentId: String,
                       completion: @escaping (BlankDataResponse) -> Void) {
        NetworkService.shared.comment.deleteComment(categoryId: categoryId, commentId: commentId) { result in
            switch result {
            case .success(let response):
                guard let data = response as? BlankDataResponse else { return }
                completion(data)
                self.getComment(categoryId,self.page,self.size)
                print("Num: \(self.Num)")
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

    private func getReport(_ categoryId: String, _ commentId: String) {
        NetworkService.shared.report.getReport(categoryId: categoryId, commentId: commentId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? ReportAvailableResponse else { return }
                self?.reportAvailable = data.isAvailable
                if self?.reportAvailable == true {
                    let reportViewController = ReportViewController(categoryId: self?.categoryId, commentId: self?.reportCommentID)
                    reportViewController.modalPresentationStyle = .overFullScreen
                    self?.present(reportViewController, animated: false)
                } else {
                    let alert = UIAlertController(title: "이미 신고한 댓글입니다.", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                        return
                    }
                    alert.addAction(okAction)
                    self?.present(alert, animated: true)
                }
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data.message)
            case .pathErr:
                print("pathErrrrrr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
