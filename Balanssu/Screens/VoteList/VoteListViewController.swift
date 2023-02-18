//
//  VoteListViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import SnapKit

class VoteListViewController: BaseViewController {
    let backButton = BackButton(type: .system)
    
    private let tableView : UITableView = { // 테이블 뷰 생성
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(VoteListTableViewCell.self, forCellReuseIdentifier: VoteListTableViewCell.identifier)
            return tableView
    }()
    
    override func setViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func setConstraints() {
                
        // 1. superView에 맞게 적용
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // 2. safeAreaLayoutGuide에 맞게 적용
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
                
        // 3. superView에 맞게 적용 한 뒤 inset 적용
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
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
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "밸런슈 목록"
    }

}

extension VoteListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VoteListTableViewCell.identifier, for: indexPath) as! VoteListTableViewCell
        cell.voteTitle.text = "제목입니다-------------"
        cell.voteTitle.font = UIFont(name: "AppleSDGothicNeoR", size: 12.0)
        return cell
    }
}

extension VoteListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
