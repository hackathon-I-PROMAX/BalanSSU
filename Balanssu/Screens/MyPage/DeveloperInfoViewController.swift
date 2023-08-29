//
//  DeveloperInfoViewController.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/07/08.
//

import UIKit
import SnapKit

class DeveloperInfoViewController: BaseViewController {
    let part = ["PM", "BackEnd", "iOS", "iOS", "iOS", "Design", "Legal", "Legal", "Legal"]
    let name = ["최서현", "송준희", "이조은", "김규철", "박지윤", "이시은", "이주연", "노금구", "방민하"]
    let imageArr: [UIImage] = [ImageLiterals.cindy, ImageLiterals.mike, ImageLiterals.joni, ImageLiterals.javier, ImageLiterals.bibi, ImageLiterals.joeum, ImageLiterals.julia, ImageLiterals.nine, ImageLiterals.chloe]

    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let teamImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.teamLabel

        return image
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(DeveloperInfoTableViewCell.self, forCellReuseIdentifier: DeveloperInfoTableViewCell.identifier)
        tableView.isScrollEnabled = false

        return tableView
    }()

    let askLabel: UILabel = {
        let label = UILabel()
        label.text = "💬 문의를 원하시나요?"
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 15.0)
        label.textColor = .black

        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "balanssu.contact@gmail.com"
        label.font = UIFont(name: "AppleSDGothicNeoM00", size: 15.0)
        label.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)

        return label
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
        navigationItem.title = "만든 사람들😎"
        navigationItem.leftBarButtonItem = backBarButton
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setViewHierarchy() {
        self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubview(teamImageView)
        contentView.addSubview(tableView)
        contentView.addSubview(askLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(copyrightLabel)
    }

    override func setConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(contentScrollView.contentLayoutGuide)
            $0.width.equalTo(contentScrollView.frameLayoutGuide)
            $0.height.equalTo(900)
        }

        teamImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(teamImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(26)
            $0.height.equalTo(625)
        }

        askLabel.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(37)
            $0.leading.equalToSuperview().inset(24)
        }

        emailLabel.snp.makeConstraints {
            $0.top.equalTo(askLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(24)
        }

        copyrightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailLabel.snp.bottom).offset(110)
        }
    }
    
    func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
}

extension DeveloperInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeveloperInfoTableViewCell.identifier, for: indexPath) as! DeveloperInfoTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = name[indexPath.row]
        cell.partLabel.text = part[indexPath.row]
        cell.profileImage.image = imageArr[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
