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
}

class CoinDetailPresenter: CoinDetailPresentationLogic {
    weak var viewController: CoinDetailViewControllerDisplayLogic?

    func performPresentErrorDialog(response: CoinDetailModels.PresentErrorDialog.Response) {
        viewController?.displayErrorDialog(viewModel: .init(title: "Oops!",
                                                            message: response.error?.localizedDescription ?? "Something went wrong."))
    }
}

// MARK: - Private Method

private extension CoinDetailPresenter {}
