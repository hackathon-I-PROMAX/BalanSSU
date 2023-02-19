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
    
    private lazy var container = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let commentField : UITextField = {
        let field = UITextField()
        field.placeholder = "댓글을 입력하세요."
        return field
    }()
    
    private let commentButton : UIButton = {
        let button = UIButton()
        //button.setImage(UIImage(systemName: "pareplane"), for: .normal)
        button.titleLabel?.text = "done"
        return button
    }()
    
    override func setViewHierarchy() {
        self.view.addSubview(tableView)
        //commentField.leftView = commentButton
        self.view.addSubview(container)
        stackView.addArrangedSubview(commentButton)
        stackView.addArrangedSubview(commentField)
        container.addSubview(stackView)

    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 500, left: 0, bottom: 0, right: 0))
        }
        
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(60)
            $0.bottom.equalTo(tableView.snp.top).offset(15)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        commentField.snp.makeConstraints {
            //$0.height.lessThanOrEqualTo(maxHeight)
            $0.leading.equalToSuperview().inset(10)
            $0.height.greaterThanOrEqualTo(48)
            $0.top.equalToSuperview().inset(1)
        }

        commentButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(44)
            $0.height.equalTo(48)
        }

    }
    
    func setLayouts() {
        tableView.dataSource = self
        tableView.delegate = self
        
        setViewHierarchy()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayouts()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        //let backButton = makeBarButtonItem(with: backButton)
        //navigationItem.leftBarButtonItem = backButton
    }
}

extension VoteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentListTableViewCell.identifier, for: indexPath) as! CommentListTableViewCell
        cell.img.image = UIImage(named: "ppussung")
        cell.name.text = "뿌슝이"
        cell.badge.text = "글로벌미디어학부"
        cell.comment.text = "댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다댓글입니다"
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
}

extension VoteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
