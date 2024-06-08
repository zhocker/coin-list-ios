//
//  ViewController.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.routeToMain()
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

