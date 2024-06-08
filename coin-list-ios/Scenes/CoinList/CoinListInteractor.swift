//
//  CoinListInteractor.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol CoinListInteractorBusinessLogic: AnyObject {
    func getCoinList(request: CoinListModels.GetCoinList.Request)
    func loadMore(request: CoinListModels.LoadMore.Request)
}

// sourcery: AutoMockable
protocol CoinListInteractorDataStore: AnyObject {}

// MARK: - Interactor
class CoinListInteractor: CoinListInteractorBusinessLogic {
    
    var presenter: CoinListPresentationLogic?
    var worker = CoinListWorker()
    
    var coins: [Coin] = []
    var keyword: String = ""
    
    func getCoinList(request: CoinListModels.GetCoinList.Request) {
        if self.keyword != request.keyword {
            self.coins.removeAll()
        }
        self.worker.fetchCoins(offset: 0, keyword: request.keyword) { [weak self] coins, error in
            guard let self = self else { return }
            if let error = error {
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
            } else {
                self.coins.append(contentsOf: coins)
                let items = self.worker.generateDisplayCellItems(keyword: request.keyword, coins: self.coins)
                self.presenter?.performPresentCoinList(response: .init(items: items))
            }
        }
        
    }
    
    func loadMore(request: CoinListModels.LoadMore.Request) {
        self.worker.fetchCoins(offset: self.coins.count, keyword: request.keyword) { [weak self] coins, error in
            guard let self = self else { return }
            if let error = error {
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
            } else {
                self.coins.append(contentsOf: coins)
                let items = self.worker.generateDisplayCellItems(keyword: request.keyword, coins: self.coins)
                self.presenter?.performPresentCoinList(response: .init(items: items))
            }
        }
    }
    
}

// MARK: - Private functions
private extension CoinListInteractor {

    
}

// MARK: - Data Store
extension CoinListInteractor: CoinListInteractorDataStore {
    
}
