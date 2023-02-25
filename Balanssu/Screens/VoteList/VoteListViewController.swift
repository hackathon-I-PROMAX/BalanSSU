//
//  VoteListViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import SnapKit

class VoteListViewController: BaseViewController {
    
    var voteList: [[String]] = [["HOT","환승연애 vs 잠수이별","123"],["HOT","아이폰 vs 갤럭시","333"],["","대학원생 되기 vs 대학교 10년 다니기","48"], ["마감","평생 떡만 먹기 vs 평생 빵만 먹기","123"]]
    
    let backButton = BackButton(type: .system)
    
    private let tableView : UITableView = { // 테이블 뷰 생성
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(VoteListTableViewCell.self, forCellReuseIdentifier: VoteListTableViewCell.identifier)
            return tableView
    }()
    
    lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: ImageLiterals.navigationBarBackButton, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()
    
    @objc func backBarButtonTapped() {
        print("tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
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
        self.navigationItem.leftBarButtonItem = backBarButton

        setLayouts()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        

        //let backButton = makeBarButtonItem(with: backButton)
        //navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "전체보기"
    }

}

extension VoteListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
    CGFloat {
               return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VoteListTableViewCell.identifier, for: indexPath) as! VoteListTableViewCell
        cell.voteTitle.text = "잠수 이별 vs 환승이별"
        cell.badge.text = "HOT"
        cell.participant.text = "100명 참여"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = VoteViewController()
        //let index: IndexPath = indexPath
        //nextViewController.asset = self.fetchResult[index.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
        print("select \(indexPath.row)")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

