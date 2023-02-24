//
//  VoteViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import SnapKit

class VoteViewController: BaseViewController {
    let backButton = BackButton(type: .system)
    
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
    
    @objc func backBarButtonTapped() {
        print("tapped")
        self.navigationController?.popViewController(animated: true)
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
        self.view.addSubview(container)
        container.addSubview(commentField)
        self.commentField.rightView = commentButton
        self.commentField.rightViewMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(tableView)

    }
    
    override func setConstraints() {
        container.snp.makeConstraints {
            //$0.top.equalTo(view.safeAreaLayoutGuide).inset(450)
            $0.bottom.equalTo(tableView.snp.top).offset(0)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            //$0.bottom.equalTo(tableView.snp.top).offset(-10)
        }
        commentField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview().inset(3)
        }
        
        tableView.snp.makeConstraints {
            $0.height.equalTo(198)
//            $0.top.equalTo(container.snp.bottom).offset(3)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            //$0.bottom.equalToSuperview()
        }
    }
    
    func setLayouts() {
        tableView.dataSource = self
        tableView.delegate = self
        commentField.delegate = self
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = backBarButton

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
