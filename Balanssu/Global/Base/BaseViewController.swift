//
//  BaseViewController.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/18.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    public var disposeBag: DisposeBag = .init()

    
    var swipeRecognizer: UISwipeGestureRecognizer!
    let realBackButton = UIButton().then {
        $0.setImage(ImageLiterals.navigationBarBackButton, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchy()
        setConstraints()
        configUI()
        setupNavigationBar()

        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func setViewHierarchy() {
        
    }
    
    func setConstraints() {
        
    }

    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
    
    func configUI() {
        view.backgroundColor = .white
    }
        
    func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: realBackButton)
    }
}
