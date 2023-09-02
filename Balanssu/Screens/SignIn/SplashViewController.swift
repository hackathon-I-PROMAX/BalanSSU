//
//  SplashViewController.swift
//  Balanssu
//
//  Created by 이조은 on 2023/09/01.
//

import UIKit

import SnapKit

final class SplashViewController: UIViewController {

    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.splash
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setConstraints()

        updateAlert()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateAlert()
    }

    func setHierarchy() {
        self.view.addSubview(splashImageView)
    }

    func setConstraints() {
        splashImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SplashViewController {
    public func needUpdate() -> Bool {
        print("=== needUpdate")
        /// net.joeun.Balanssu
        guard
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let url = URL(string: "https://itunes.apple.com/lookup?bundleId=net.joeun.Balanssu"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let results = json["results"] as? [[String: Any]],
            results.count > 0,
            let appStoreVersion = results[0]["version"] as? String

        else { return false }


        let nowVersionArr = version.split(separator: ".").map { $0 }
        let storeVersionArr = appStoreVersion.split(separator: ".").map { $0 }

        print("=== \(nowVersionArr)")
        print("=== \(storeVersionArr)")

        // 가장 앞자리가 다르면 -> 업데이트 필요
        if nowVersionArr[0] < storeVersionArr[0] {
            return true
        } else {
            if  nowVersionArr[1] < storeVersionArr[1] { // 두번째 자리가 달라도 업데이트 필요
                return true
            } else { return false } // 그 이외에는 업데이트 필요 없음
        }

    }

    public func updateAlert() {
        if (needUpdate()){
            // 업데이트 필요
            let updateAlert = UIAlertController(title: "업데이트 알림", message: "필수 업데이트가 있습니다. 업데이트를 하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "업데이트", style: .default) { _ in
                // 밸런슈 AppStore 주소
                guard let url = URL(string: "https://seohyeon03.notion.site/BalanSSU-9a09bd156e994145a3ca41498b1dccc2?pvs=4") else { return }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            updateAlert.addAction(okAction)
            self.present(updateAlert, animated: true)
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                if UserDefaultHandler.loginStatus == true {
                    sceneDelegate?.changeRootView()
                } else {
                    sceneDelegate?.changeStartView()
                }
            }
        }
    }
}
