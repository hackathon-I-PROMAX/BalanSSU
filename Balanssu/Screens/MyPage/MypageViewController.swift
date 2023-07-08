//
//  MypageViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/02/18.
//

import UIKit
import SnapKit
import YDS

class MypageViewController: BaseViewController {
    let data = [["밸런슈가 궁금해요", "만든 사람들", "서비스 이용약관", "오픈소스 사용정보", "개인정보 처리방침"], ["비밀번호 변경", "계정 관리"]]

    let backButton = BackButton(type: .system)
    
    let contentView = UIView()

    var infoCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(51))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(51))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
//        let sectionHeader = self.createSectionHeader()
//        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false

        return collectionView
    }()

    private let profileView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ppussung")
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoB00", size: 20.0)
        label.textColor = .black
        label.text = "nameLabel"
        label.textAlignment = .center
        return label
    }()
    
    private let userInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.text = "userInfo / schoolAge"
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeoR00", size: 15.0)
        label.textColor = .black
        label.text = "@idLabel"
        label.textAlignment = .center
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0.249, green: 0.378, blue: 0.629, alpha: 1)
        button.backgroundColor = nil
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moreButtonTap), for: .touchUpInside)
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
    
    @objc
    func moreButtonTap() {
        print("=====질문만들기 버튼 클릭 =====")
        guard let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScUWg9XFi7fnVLgcJux0kTPLB1yzBjzIUU_BdR19XzGjyccMQ/viewform"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
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
        contentView.addSubview(profileView)
        contentView.addSubview(idLabel)
        contentView.addSubview(userInfo)
        contentView.addSubview(nameLabel)
        
        self.view.addSubview(contentView)
        self.view.addSubview(infoCollectionView)
        self.view.addSubview(moreButton)
        moreButton.addSubview(moreLabel)
        
        self.view.addSubview(grayLine)
    }

    override func setConstraints() {
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(3)
            $0.top.equalToSuperview().offset(110)
            $0.height.equalTo(120)
        }
        
        infoCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(grayLine.snp.bottom)
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
    }

    func setLayouts() {
        setViewHierarchy()
        setConstraints()
        setCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = backBarButton
        
        getMyPage()
        setLayouts()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "마이페이지"
    }
}

//data 가져오기
extension MypageViewController {
    func getMyPage() {
        NetworkService.shared.myPage.getMyPage() { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? MyPageResponse else { return }
                print("==== \(String(describing: data))")
                self?.nameLabel.text = data.user.nickname
                self?.userInfo.text = "\(data.user.departure) / \(data.user.schoolAge)학번"
                self?.idLabel.text = "@\(data.user.username)"
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

extension MypageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppInfoCollectionViewCell.identifier,
                                                            for: indexPath) as? AppInfoCollectionViewCell else { return UICollectionViewCell() }
        cell.label.text = data[indexPath.section][indexPath.row]

        return cell
    }
    
    func setCollectionView() {
        infoCollectionView.register(AppInfoCollectionViewCell.self, forCellWithReuseIdentifier: AppInfoCollectionViewCell.identifier)
        infoCollectionView.register(AppInfoCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: AppInfoCollectionViewHeaderCell.identifier)
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                             heightDimension: .absolute(51))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .topLeading)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppInfoCollectionViewHeaderCell.identifier, for: indexPath)
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}

extension MypageViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.navigationController?.pushViewController(AboutBalanSSUViewController(), animated: true)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            self.navigationController?.pushViewController(DeveloperInfoViewController(), animated: true)
        }
    }
}
