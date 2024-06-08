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
    func shareText(invitationText: String, viewController: UIViewController)
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
    
    func shareText(invitationText: String, viewController: UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: [invitationText], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.postToFacebook,.postToTwitter,.addToReadingList, .assignToContact, .saveToCameraRoll]
        
        // For iPad, you must specify a sourceView or sourceRect
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.sourceView = viewController.view
            popoverPresentationController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        DispatchQueue.main.async {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}

