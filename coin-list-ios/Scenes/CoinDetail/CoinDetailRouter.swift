//
//  CoinDetailRouter.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol CoinDetailRouterRoutingLogic {
    static func createScene() -> CoinDetailViewController
}

class CoinDetailRouter: CoinDetailRouterRoutingLogic {    
    weak var viewController: CoinDetailViewController?

    static func createScene() -> CoinDetailViewController {
        let viewController = CoinDetailViewController()
        let interactor = CoinDetailInteractor()
        let presenter = CoinDetailPresenter()
        let router = CoinDetailRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
