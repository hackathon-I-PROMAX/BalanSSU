//
//  HotCollectionView.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

import SnapKit

import Then

class HotCollectionView: UITableViewCell {
    
    static let identifier = "HotCollectionView"
    
    let hotImageArray: [UIImage] = [ImageLiterals.navigationBarBackButton, ImageLiterals.navigationBarBackButton, ImageLiterals.navigationBarBackButton]
    let hotItitleArray: [String] = ["숭실대 가성비 카페", "숭실대 가성비 카페", "숭실대 가성비 카페"]
    let hotdeadLineArray: [String] = ["10", "5", "90"]
    
    var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionview.backgroundColor = .systemCyan
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewHierarchy()
        setConstraints()
        setUpcollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpcollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HotCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: HotCollectionViewCell.identifier)
    }
    
    func setViewHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension HotCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotCollectionViewCell.identifier, for: indexPath) as! HotCollectionViewCell
        
        cell.imageView.image = hotImageArray[indexPath.row]
        cell.hotTitleLabel.text = hotItitleArray[indexPath.item]
        cell.deadLineLabel.text = "D+" + hotdeadLineArray[indexPath.item]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hot")
    }
}

extension HotCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.bounds.width - 25) / 2.5
        
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
    }
}
