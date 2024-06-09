//
//  CoinListPresenter.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

//source: AutoMockable
protocol CoinListPresentationLogic: AnyObject {
    func performPresentErrorDialog(response: CoinListModels.PresentErrorDialog.Response)
    func performPresentCoinList(response: CoinListModels.GetCoinList.Response)
    func performPresentEmptyState(response: CoinListModels.PresentEmptyState.Response)
    func performPresentFooterView(response: CoinListModels.PresentFooterView.Response)
    
}

class CoinListPresenter: CoinListPresentationLogic {
    weak var viewController: CoinListViewControllerDisplayLogic?

    func performPresentErrorDialog(response: CoinListModels.PresentErrorDialog.Response) {
        viewController?.displayErrorDialog(viewModel: .init(title: "Oops!",
                                                            message: response.error?.localizedDescription ?? "Something went wrong."))
    }
    
    func performPresentCoinList(response: CoinListModels.GetCoinList.Response) {
        viewController?.displayCoinList(viewModel: .init(items: response.items))
    }
    
    func performPresentEmptyState(response: CoinListModels.PresentEmptyState.Response) {
        viewController?.displayEmptyState(viewModel: .init())
    }
    
    func performPresentFooterView(response: CoinListModels.PresentFooterView.Response) {
        viewController?.displayFooterView(viewModel: .init(isHidden: response.isHidden))
    }

}

// MARK: - Private Method

private extension CoinListPresenter {}
