//
//  MypageViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import YDS

final class MypageViewController: BaseViewController {
    
    var viewModel: MypageViewModel
    
    init(viewModel: MypageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView = UIView()
    private let profileView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ppussung")
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.backgroundColor = .gray
        
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 20.0)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var userInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "밸런스게임 질문을 만들고 싶다면?"
        label.textColor = UIColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.943, green: 0.943, blue: 0.943, alpha: 1)
        return view
    }()
    private lazy var settingTableView: UITableView = {
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
        bind()
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "마이페이지"
    }
    
    private func bind() {
        let input = MypageViewModel.Input(viewWillAppear: rx.viewWillAppear.take(1).map { _ in })
        let output = viewModel.transform(input: input)
        
        output.authInfo
            .withUnretained(self)
            .bind { owner, userInfo in
                owner.nameLabel.text = userInfo.user.nickname
                owner.userInfo.text = "\(userInfo.user.mbti) / \(userInfo.user.schoolAge)학번"
                owner.idLabel.text = "@\(userInfo.user.username)"
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        settingTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] (indexPath: IndexPath) in
                let row = indexPath.row
                let sectionType = MyPageType.allCases[indexPath.section]
                
                switch sectionType {
                case .appInfo:
                    if row == 0 {
                        self?.navigationController?.pushViewController(AboutBalanSSUViewController(), animated: true)
                    } else if row == 1 {
                        self?.navigationController?.pushViewController(DeveloperInfoViewController(), animated: true)
                    } else if row == 2 {
//                        self?.navigationController?.pushViewController(VC, animated: true)
                    } else if row == 3 {
//                        self?.navigationController?.pushViewController(VC, animated: true)
                    } else {
//                        self?.navigationController?.pushViewController(VC, animated: true)
                    }
                case .account:
                    if row == 0 {
                        self?.errorPresentAlert(type: .changePasswordError)
                    } else  {
                        let VC = AccountViewController()
                        self?.navigationController?.pushViewController(VC, animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        moreButton.rx.tap
            .bind { _ in
                guard let url = URL(string: URLConst.createQuestion), UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            .disposed(by: disposeBag)
        
        realBackButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func setViewHierarchy() {
        contentView.addSubview(profileView)
        contentView.addSubview(idLabel)
        contentView.addSubview(userInfo)
        contentView.addSubview(nameLabel)
        
        self.view.addSubview(contentView)
        self.view.addSubview(moreButton)
        moreButton.addSubview(moreLabel)
        
        self.view.addSubview(grayLine)
        self.view.addSubview(settingTableView)
    }
    override func setConstraints() {
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(3)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(120)
        }
        
        profileView.snp.makeConstraints {
            $0.size.width.height.equalTo(100)
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(userInfo.snp.top).offset(-4)
            $0.leading.equalTo(profileView.snp.trailing).offset(11)
        }
        
        userInfo.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileView.snp.trailing).offset(11)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(userInfo.snp.bottom).offset(4)
            $0.leading.equalTo(profileView.snp.trailing).offset(11)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentView.snp.bottom).offset(16)
            $0.height.equalTo(49)
            $0.width.equalTo(335)
        }
        moreLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        grayLine.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(moreButton.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(4)
        }
        
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(grayLine.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
            
    }
}

extension MypageViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MyPageType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(describing: MyPageType.allCases[section])
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont(name: "AppleSDGothicNeoB00", size: 16)
        header.textLabel?.textColor = .black
        header.textLabel?.sizeToFit()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyPageType.allCases[section].numberOfRowInSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: MypageTableViewCell.identifier, for: indexPath) as? MypageTableViewCell else { return UITableViewCell() }
        cell.setData(text: MyPageType.allCases[indexPath.section].contents[indexPath.row])
        return cell
    }
    
}
