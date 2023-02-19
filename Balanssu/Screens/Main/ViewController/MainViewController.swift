//
//  MainViewController.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/17.
//

import UIKit
import SnapKit
import Then

class MainViewController: BaseViewController {
    
    private let myPageButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: MainViewController.self, action: nil)
    
    //    private let topicCollectionView = TopicCollectionView()
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.tertiarySystemGroupedBackground
    }
    
    let hotCollectionView = HotCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func setViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configUI() {
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HotCollectionViewHeader.self, forHeaderFooterViewReuseIdentifier: HotCollectionViewHeader.identifier)
        tableView.register(DeadLineCollectionViewHeader.self, forHeaderFooterViewReuseIdentifier: DeadLineCollectionViewHeader.identifier)
        tableView.register(TopicCollectionView.classForCoder(), forCellReuseIdentifier: TopicCollectionView.identifier)
        tableView.register(HotCollectionView.classForCoder(), forCellReuseIdentifier: HotCollectionView.identifier)
        tableView.register(DeadLineCollectionView.classForCoder(), forCellReuseIdentifier: DeadLineCollectionView.identifier)
        
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.rightBarButtonItem = myPageButton
        navigationItem.title = "밸런슈"
    }
    
    @objc func voteListBtn(sender: UIButton) {
        print("voteList")
    }
}
    
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            switch section {
            case 1:
                let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HotCollectionViewHeader.identifier) as! HotCollectionViewHeader
                
                headerCell.allListButton.addTarget(self, action: #selector(voteListBtn), for: .touchUpInside)
                
                return headerCell
            case 2:
                let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: DeadLineCollectionViewHeader.identifier) as! DeadLineCollectionViewHeader
                
                headerCell.deadLineListButton.addTarget(self, action: #selector(voteListBtn), for: .touchUpInside)
                
                return headerCell
            
            default:
                return UIView()
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TopicCollectionView.identifier, for: indexPath) as! TopicCollectionView
                
                cell.cellDelegate = self
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: HotCollectionView.identifier, for: indexPath) as! HotCollectionView
                
                cell.cellDelegate = self
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: DeadLineCollectionView.identifier, for: indexPath) as! DeadLineCollectionView
                
                cell.cellDelegate = self
                return cell
            default:
                return UITableViewCell()
            }
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            switch section {
            case 0:
                return 0
            case 1:
                return 60
            case 2:
                return 60
            default:
                return CGFloat.leastNormalMagnitude
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 0:
                return 200
            case 1:
                return 190
            case 2:
                return 148
            default:
                return 1000
            }
        }
    }

extension MainViewController: TopCollectionViewCellDelegate, HotCollectionViewCellDelegate, DeadLineCollectionViewCellDelegate {
    func collectionView(collectionviewcell: HotCollectionViewCell?, index: Int, didTappedInTableViewCell: HotCollectionView) {
        print("Hot")
    }
    
    func collectionView(collectionviewcell: TopicCollectionViewCell?, index: Int, didTappedInTableViewCell: TopicCollectionView) {
        print("topic")
        }
    
    func collectionView(collectionviewcell: DeadLineCollectionViewCell?, index: Int, didTappedInTableViewCell: DeadLineCollectionView) {
        print("deadLine")
    }
}


