//
//  CoinListRouter.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

protocol CoinListRouterRoutingLogic {
    static func createScene() -> CoinListViewController
    func shareText(invitationText: String)
    func routeToCoinDetail(coin: Coin)
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
    
    func shareText(invitationText: String) {
        guard let viewController = self.viewController else { return }
        DispatchQueue.main.async {
            let activityViewController = UIActivityViewController(activityItems: [invitationText], applicationActivities: nil)
            activityViewController.excludedActivityTypes = [.postToFacebook,.postToTwitter,.addToReadingList, .assignToContact, .saveToCameraRoll]
            
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = viewController.view
                popoverPresentationController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func routeToCoinDetail(coin: Coin) {
        guard let viewController = self.viewController else { return }
        DispatchQueue.main.async {
            let vc = CoinDetailRouter.createScene(coin: coin)
            viewController.present(vc, animated: true)
        }
    }
    
}

