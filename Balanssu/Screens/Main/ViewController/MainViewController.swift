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
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.tertiarySystemGroupedBackground
    }
    
    let hotCollectionView = HotCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMainCategories()
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
        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 0
        
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "myPageButton.svg"), style: .plain, target: self, action: #selector(myPageBtn))
        
        let logo = UIImage(named: "mainTitle.svg")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func voteListBtn(sender: UIButton) {
        let nextViewController = VoteListViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        print("voteList")
    }
    
    @objc func myPageBtn(sender: UIBarButtonItem) {
        let nextViewController = MypageViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        print("myPageBtn")
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
                
                headerCell.tintColor = .white
                headerCell.allListButton.addTarget(self, action: #selector(voteListBtn), for: .touchUpInside)
                
                return headerCell
            case 2:
                let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: DeadLineCollectionViewHeader.identifier) as! DeadLineCollectionViewHeader
                
                headerCell.tintColor = .white
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
                return 55
            case 2:
                return 55
            default:
                return CGFloat.leastNormalMagnitude
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 0:
                return 200
            case 1:
                return 160
            case 2:
                return 160
            default:
                return 1000
            }
        }
    }

extension MainViewController: TopCollectionViewCellDelegate, HotCollectionViewCellDelegate, DeadLineCollectionViewCellDelegate {
    func collectionView(collectionviewcell: HotCollectionViewCell?, index: Int, didTappedInTableViewCell: HotCollectionView) {
        let nextViewController = VoteViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func collectionView(collectionviewcell: TopicCollectionViewCell?, index: Int, didTappedInTableViewCell: TopicCollectionView) {
        print("topic")
        }
    
    func collectionView(collectionviewcell: DeadLineCollectionViewCell?, index: Int, didTappedInTableViewCell: DeadLineCollectionView) {
        let nextViewController = VoteViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        print("deadLine")
    }
}

extension MainViewController {
    func getMainCategories() {
        NetworkService.shared.main.getMainCategories {[weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? MainCategoriesResponse else { return }
//                hotCollectionView.closedCategories = data.closedCategories
                self?.hotCollectionView.hottestCategories = data.hotCategories
                print(self?.hotCollectionView.hottestCategories)
                self?.tableView.reloadData()
            case .requestErr(let errorResponse):
                dump(errorResponse)
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
