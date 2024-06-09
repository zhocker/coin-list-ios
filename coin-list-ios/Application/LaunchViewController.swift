//
//  LaunchViewController.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import Lottie
import SnapKit

class LaunchViewController: UIViewController {
    
    private let loadingView: LottieAnimationView = {
        let loadingView = LottieAnimationView(asset: "rocket")
        loadingView.animationSpeed = 1
        loadingView.loopMode = .loop
        return loadingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.start()
    }

    func setupView() {
        self.view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
        loadingView.play()
    }
    
    private func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) { [weak self] in
            guard let self = self else { return }
            self.dimissLottieView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.routeToMain()
            }
        }
    }
    
    private func dimissLottieView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.loadingView.alpha = 0
        }) { _ in
            self.loadingView.removeFromSuperview()
        }
    }

    func routeToMain() {
        guard
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        else {
            return
        }
        
        if let window = sceneDelegate.window {
            window.rootViewController = CoinListRouter.createScene()
            window.makeKeyAndVisible()
        }
    }

}

