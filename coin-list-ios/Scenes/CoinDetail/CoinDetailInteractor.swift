//
//  CoinDetailInteractor.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

protocol CoinDetailInteractorBusinessLogic: AnyObject {
    func getCoinDetail(request: CoinDetailModels.GetCoinDetail.Request)
}

protocol CoinDetailInteractorDataStore: AnyObject {
    var coinViewModel: CoinViewModel? { get set }
    var websiteUrl: String { get }
}

// MARK: - Interactor
class CoinDetailInteractor: CoinDetailInteractorBusinessLogic, CoinDetailInteractorDataStore {
    var presenter: CoinDetailPresentationLogic?
    var worker = CoinDetailWorker()
    var coinViewModel: CoinViewModel? = nil
    var coinDetailViewModel: CoinDetailViewModel? = nil
    var websiteUrl: String {
        return self.coinDetailViewModel?.websiteUrl ?? "https://coinranking.com/"
    }

    func getCoinDetail(request: CoinDetailModels.GetCoinDetail.Request) {
        worker.fetchCoinDetail(uuid: request.uuid) { [weak self] coin, error in
            guard let self = self else { return }
            if let coin = coin {
                let coinDetailViewModel = self.worker.convertCoinToCoinViewModel(coin: coin)
                self.coinDetailViewModel = coinDetailViewModel
                self.presenter?.performPresentCoinDetail(response: .init(coin: coinDetailViewModel))
            } else if let error = error {
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
            } else {
                let error = AppError(message: "Something went wrong.")
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
            }
        }
    }
    
}

// MARK: - Private functions
private extension CoinDetailInteractor {
    
}

