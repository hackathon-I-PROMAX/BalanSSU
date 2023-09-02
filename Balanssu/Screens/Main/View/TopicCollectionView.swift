//
//  TopicCollectionView.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

import SnapKit
import Then

protocol TopCollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: TopicCollectionViewCell?, index: Int, didTappedInTableViewCell: TopicCollectionView)
}

final class TopicCollectionView: UITableViewCell {
    
    static let identifier = "TopicCollectionView"

    private let topicImageArray: [UIImage] = [ImageLiterals.topicCell1, ImageLiterals.topicCell2, ImageLiterals.topicCell3, ImageLiterals.topicCell4]
    
    weak var cellDelegate: TopCollectionViewCellDelegate?
    
    private var topicCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionview.backgroundColor = .clear
        collectionview.isPagingEnabled = true
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
    
    private func setUpcollectionView() {
        topicCollectionView.delegate = self
        topicCollectionView.dataSource = self
        topicCollectionView.register(TopicCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
    }
    
    private func setViewHierarchy() {
        contentView.addSubview(topicCollectionView)
    }
    
    private func setConstraints() {
        topicCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TopicCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topicCollectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as! TopicCollectionViewCell
        
        cell.bannerImageView.image = topicImageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TopicCollectionViewCell
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
}

extension TopicCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
}


