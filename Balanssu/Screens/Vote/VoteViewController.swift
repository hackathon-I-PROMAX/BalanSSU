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
            return tableView
    }()
    
    override func setViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 400, left: 0, bottom: 0, right: 0))
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
    CGFloat {
               return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentListTableViewCell.identifier, for: indexPath) as! CommentListTableViewCell
        cell.img.image = UIImage(named: "ppussung")
        cell.name.text="닉네임"
        cell.comment.text = "댓글입니다ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ"
        return cell
    }
}

extension VoteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
