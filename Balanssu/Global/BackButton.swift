//
//  BackButton.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

final class BackButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    private func configUI() {
        self.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        self.setImage(ImageLiterals.navigationBarBackButton, for: .normal)
        self.tintColor = UIColor.black
    }

}
