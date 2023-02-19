//
//  DeadLineCollectionView.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/19.
//

import UIKit

import SnapKit

import Then

protocol DeadLineCollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: DeadLineCollectionViewCell?, index: Int, didTappedInTableViewCell: DeadLineCollectionView)
}

class DeadLineCollectionView: UITableViewCell {
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 12
        static let collectionVerticalSpacing: CGFloat = 0
        static let cellWidth: CGFloat = 148
        static let cellHeight: CGFloat = 170
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: 20,
            bottom: collectionVerticalSpacing,
            right: 20)
    }
    
    static let identifier = "DeadLineCollectionView"
    
    weak var cellDelegate: DeadLineCollectionViewCellDelegate?
    
    let deadLineImageArray: [UIImage] = [ImageLiterals.deadLineCell, ImageLiterals.deadLineCell, ImageLiterals.deadLineCell]
    
    let deadLinetitleArray: [String] = ["숭실대 가성비 카페", "숭실대 가성비 카페", "숭실대 가성비 카페"]
    
    var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionview.backgroundColor = .white
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
        
        collectionView.register(DeadLineCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: DeadLineCollectionViewCell.identifier)
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

extension DeadLineCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deadLineImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeadLineCollectionViewCell.identifier, for: indexPath) as! DeadLineCollectionViewCell
        
        cell.imageView.image = deadLineImageArray[indexPath.row]
        cell.deadLineTitleLabel.text = deadLinetitleArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DeadLineCollectionViewCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
}

extension DeadLineCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.cellWidth, height: Size.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Size.collectionHorizontalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Size.collectionInsets
    }
}

