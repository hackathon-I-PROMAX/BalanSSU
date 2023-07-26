//
//  DeveloperInfoViewController.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/07/08.
//

import UIKit

class DeveloperInfoViewController: BaseViewController {
    let name = ["Cindy\nPM", "Mike\nBackEnd", "Joni\niOS", "Javier\niOS", "Bibi\niOS", "Joeum\nDesign"]
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.text = "i-PROMAX"
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 32.0)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(DeveloperInfoTableViewCell.self, forCellReuseIdentifier: DeveloperInfoTableViewCell.identifier)
        tableView.isScrollEnabled = false

        return tableView
    }()
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "Copyright i-ProMax at balanssu. 2023. All rights reserved."
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 10.0)
        label.textColor = UIColor(r: 79, g: 89, b: 133)
        
        return label
    }()
    
    lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: ImageLiterals.navigationBarBackButton, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBarButtonTapped))
        button.tintColor = .black
            return button
    }()

    @objc func backBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        navigationItem.title = "만든 사람들"
        navigationItem.leftBarButtonItem = backBarButton
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setViewHierarchy() {
        view.addSubview(teamLabel)
        view.addSubview(tableView)
        view.addSubview(copyrightLabel)
    }

    override func setConstraints() {
        teamLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(110)
            $0.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(26)
            $0.height.equalTo(390)
        }
        
        copyrightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
}

extension DeveloperInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeveloperInfoTableViewCell.identifier, for: indexPath) as! DeveloperInfoTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = name[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
