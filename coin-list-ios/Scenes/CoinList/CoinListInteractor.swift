//
//  CoinListInteractor.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

protocol CoinListInteractorBusinessLogic: AnyObject {
    func getCoinList(request: CoinListModels.GetCoinList.Request)
    func loadMore(request: CoinListModels.LoadMore.Request)
}

protocol CoinListInteractorDataStore: AnyObject {
    var displayCellItems: [CoinListModels.DisplayCellItem] { get }
}

// MARK: - Interactor
class CoinListInteractor: CoinListInteractorBusinessLogic {
    
    var presenter: CoinListPresentationLogic?
    var worker = CoinListWorker()
    
    private var isLoading = false
    private var keyword: String = ""
    private var coins: [Coin] = []
    private var items: [CoinListModels.DisplayCellItem] = []

    func getCoinList(request: CoinListModels.GetCoinList.Request) {
        if self.keyword != request.keyword {
            self.coins.removeAll()
        }
        
        guard !self.isLoading else { return }
        self.isLoading = true

        self.worker.fetchCoins(offset: 0, keyword: request.keyword) { [weak self] coins, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
            } else {
                self.coins.append(contentsOf: coins)
                items = self.worker.generateDisplayCellItems(keyword: request.keyword, coins: self.coins)
                self.presenter?.performPresentCoinList(response: .init(items: items))
            }
        }
        
    }
    
    func loadMore(request: CoinListModels.LoadMore.Request) {
        guard !self.isLoading else { return }
        self.isLoading = true
        let keyword: String = self.keyword
        self.worker.fetchCoins(offset: self.coins.count, keyword: keyword) { [weak self] coins, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
            } else {
                self.coins.append(contentsOf: coins)
                self.items = self.worker.generateDisplayCellItems(keyword: keyword, coins: self.coins)
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
    
    var displayCellItems: [CoinListModels.DisplayCellItem] {
        return self.items
    }
    
}
