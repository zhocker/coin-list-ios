//
//  CoinListRouter.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol CoinListRouterRoutingLogic {
    static func createScene() -> CoinListViewController
}

class CoinListRouter: CoinListRouterRoutingLogic {    
    weak var viewController: CoinListViewController?

    static func createScene() -> CoinListViewController {
        let viewController = CoinListViewController()
        let interactor = CoinListInteractor()
        let presenter = CoinListPresenter()
        let router = CoinListRouter()
        
        viewController.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
