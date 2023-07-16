//
//  AccountViewController.swift
//  Balanssu
//
//  Created by 김규철 on 2023/07/07.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class AccountViewController: BaseViewController {
            
    private lazy var accountTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MypageTableViewCell.classForCoder(), forCellReuseIdentifier: MypageTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 50
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "계정 관리"
    }
        
    private func bindAction() {
        accountTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] (indexPath: IndexPath) in
                let row = indexPath.row
                let sectionType = AccountType.allCases[row]
                
                switch sectionType {
                case .logout:
                    self?.presentAlert(type: .logout, leftButtonAction: nil) {
                        let viewModel = AccountViewModel(myPageDataSource: DefaultMyPageDataSource())
                        viewModel.resetUserDefaultValues()
                        let startViewController = StartViewController()
                        self?.navigationController?.setViewControllers([startViewController], animated: true)
                    }
                case .withdrawal:
                    self?.presentAlert(type: .withDraw, leftButtonAction: nil) {
                        let withDrawViewController = WithDrawViewController(viewModel: AccountViewModel(myPageDataSource: DefaultMyPageDataSource()))
                        self?.navigationController?.pushViewController(withDrawViewController, animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        
        
        realBackButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func setViewHierarchy() {
        self.view.addSubview(accountTableView)
    }
    
    override func setConstraints() {
        accountTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = accountTableView.dequeueReusableCell(withIdentifier: MypageTableViewCell.identifier, for: indexPath) as? MypageTableViewCell else { return UITableViewCell() }
        cell.setData(text: AccountType.allCases[indexPath.row].rawValue)
        return cell
    }
    
}
