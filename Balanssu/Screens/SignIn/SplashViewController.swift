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
    public func needUpdate(completion: @escaping (Bool) -> Void) {
        print("=== needUpdate")

        // 버전 정보 가져오기
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            completion(false)
            return
        }

        // App Store에서 앱 정보 가져오기
        let urlString = "https://itunes.apple.com/lookup?bundleId=net.joeun.Balanssu"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                    completion(false)
                    return
                }

                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                           let results = json["results"] as? [[String: Any]], results.count > 0,
                           let appStoreVersion = results[0]["version"] as? String {

                            // 버전 비교 로직
                            let nowVersionArr = version.split(separator: ".").map { Int($0) ?? 0 }
                            let storeVersionArr = appStoreVersion.split(separator: ".").map { Int($0) ?? 0 }

                            if nowVersionArr[0] < storeVersionArr[0] {
                                completion(true)
                            } else if nowVersionArr[1] < storeVersionArr[1] {
                                completion(true)
                            } else {
                                completion(false)
                            }
                        } else {
                            completion(false)
                        }
                    } catch {
                        print("JSON 파싱 에러: \(error)")
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            }
        }

        task.resume()
    }

    public func updateAlert() {
        needUpdate { (updateNeeded) in
            if updateNeeded {
                // 업데이트가 필요한 경우
                let updateAlert = UIAlertController(title: "업데이트 알림", message: "필수 업데이트가 있습니다. 업데이트를 하시겠습니까?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "업데이트", style: .default) { _ in
                    // 밸런슈 AppStore 주소
                    guard let url = URL(string: "https://www.notion.so/balanssu/BalanSSU-9a09bd156e994145a3ca41498b1dccc2") else { return }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                updateAlert.addAction(okAction)
                self.present(updateAlert, animated: true)
            } else {
                // 업데이트가 필요하지 않은 경우
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
}
