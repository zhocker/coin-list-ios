//
//  CoinDetailRouter.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

protocol CoinDetailRouterRoutingLogic {
    static func createScene(coinViewModel: CoinViewModel) -> CoinDetailViewController
    func openExternalBrowser(urlString: String)
}

class CoinDetailRouter: CoinDetailRouterRoutingLogic {    
    weak var viewController: CoinDetailViewController?

    static func createScene(coinViewModel: CoinViewModel) -> CoinDetailViewController {
        let viewController = CoinDetailViewController()
        let interactor = CoinDetailInteractor()
        let presenter = CoinDetailPresenter()
        let router = CoinDetailRouter()
        
        viewController.interactor = interactor
        viewController.dataStore = interactor

        viewController.dataStore.coinViewModel = coinViewModel
        
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
    
    func openExternalBrowser(urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
