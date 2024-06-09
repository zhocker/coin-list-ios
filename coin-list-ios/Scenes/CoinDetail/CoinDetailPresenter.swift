//
//  CoinDetailPresenter.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

//source: AutoMockable
protocol CoinDetailPresentationLogic: AnyObject {
    func performPresentErrorDialog(response: CoinDetailModels.PresentErrorDialog.Response)
    func performPresentCoinDetail(response: CoinDetailModels.GetCoinDetail.Response)

}

class CoinDetailPresenter: CoinDetailPresentationLogic {
    weak var viewController: CoinDetailViewControllerDisplayLogic?

    func performPresentErrorDialog(response: CoinDetailModels.PresentErrorDialog.Response) {
        viewController?.displayErrorDialog(viewModel: .init(title: "Oops!",
                                                            message: response.error?.localizedDescription ?? "Something went wrong. Please try again."))
    }
    
    func performPresentCoinDetail(response: CoinDetailModels.GetCoinDetail.Response) {
        viewController?.displayCoinDetail(viewModel: .init(coin: response.coin))
    }

}

// MARK: - Private Method

private extension CoinDetailPresenter {}
