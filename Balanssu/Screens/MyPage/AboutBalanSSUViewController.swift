//
//  AboutBalanSSUViewController.swift
//  Balanssu
//
//  Created by 박지윤 on 2023/07/08.
//

import UIKit

class AboutBalanSSUViewController: BaseViewController {
    let logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "logo2")
        
        return logoImage
    }()
    
    let contentView: UIView = {
        let view = UIView()
        
        return view
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "‘밸런슈’는\n숭실대 관련 및 여러 질문에 대해\n밸런스 게임을 하고, 의견 공유 및 자신의 취향을 알아볼 수 있는 서비스 입니다.\n\n학생들 사이에서 밸런스 게임이 굉장히 떠오르고 있으며 바이럴을 일으킵니다.\n\n자주 나오는 이야기와 즐거운 논쟁들을 주제로 숭실대 학생들은 어떤 선택을 하는지 서로 의견을 공유하는 커뮤니티를 제작하고자 했습니다.\n\n이를 통해 나오는 결과들과 유익한 정보들을 학생들에게 제공할 수 있습니다."
        label.font = UIFont(name: "AppleSDGothicNeoM00", size: 20.0)
        label.textColor = .black
        label.numberOfLines = 0
        
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
        navigationItem.title = "밸런슈가 궁금해요"
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    override func setViewHierarchy() {
        view.addSubview(contentView)
        view.addSubview(logoImage)
        
        contentView.addSubview(contentLabel)
    }

    override func setConstraints() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(110)
            $0.height.equalTo(186)
            $0.width.equalTo(350)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(26)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
}

