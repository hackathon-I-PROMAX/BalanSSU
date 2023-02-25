//
//  VoteListViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import SnapKit

class VoteListViewController: BaseViewController {
    
    var voteListArr: [voteListData] = []
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVoteList()
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
        //print("==== 11111: \(String(describing: self.voteListArr))")
        return voteListArr.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
    CGFloat {
               return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VoteListTableViewCell.identifier, for: indexPath) as! VoteListTableViewCell
        //let title: String = voteListArr[indexPath.row].title ?? ""
        cell.voteTitle.text =  voteListArr[indexPath.row].title
        cell.badge.text = voteListArr[indexPath.row].type
        if cell.badge.text == "HOT" {
            cell.badge.backgroundColor = UIColor(red: 0.878, green: 0.91, blue: 0.969, alpha: 1)
            cell.badge.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        } else if cell.badge.text == "CLOSED" {
            cell.badge.backgroundColor = UIColor(red: 0.879, green: 0.879, blue: 0.879, alpha: 1)
            cell.badge.textColor = UIColor(red: 0.437, green: 0.448, blue: 0.504, alpha: 1)
        }
        cell.participant.text = "\(voteListArr[indexPath.row].participantCount)명 참여"
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

extension VoteListViewController {
    func getVoteList() {
        NetworkService.shared.voteList.getVoteList() { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? VoteListResponse else { return }
                self?.voteListArr = data.categories
                print("==== VoteListArr Test: \(String(describing: self?.voteListArr[0]))")
                self?.tableView.reloadData()
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
