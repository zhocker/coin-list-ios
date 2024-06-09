//
//  CoinDetailRouter.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

protocol CoinDetailRouterRoutingLogic {
    static func createScene(coin: Coin) -> CoinDetailViewController
}

class CoinDetailRouter: CoinDetailRouterRoutingLogic {    
    weak var viewController: CoinDetailViewController?

    static func createScene(coin: Coin) -> CoinDetailViewController {
        let viewController = CoinDetailViewController()
        let interactor = CoinDetailInteractor()
        let presenter = CoinDetailPresenter()
        let router = CoinDetailRouter()
        
        viewController.interactor = interactor
        viewController.dataStore = interactor

        viewController.dataStore.displayCoin = coin
        
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
