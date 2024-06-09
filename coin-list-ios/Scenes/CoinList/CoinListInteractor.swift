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
    func handleLoadingFooterView(request: CoinListModels.PresentFooterView.Request)
}

protocol CoinListInteractorDataStore: AnyObject {
    var displayCellItems: [CoinListModels.DisplayCellItem] { get }
}

// MARK: - Interactor
class CoinListInteractor: CoinListInteractorBusinessLogic {
    
    var presenter: CoinListPresentationLogic?
    var worker = CoinListWorker()
    
    private var isLoading = false
    private var isLastPage = false
    private var keyword: String = ""
    private var coins: [Coin] = []
    private var items: [CoinListModels.DisplayCellItem] = []

    func getCoinList(request: CoinListModels.GetCoinList.Request) {

        self.coins.removeAll()
        self.keyword = request.keyword
        
        guard !self.isLoading else { return }
        self.isLoading = true
        self.isLastPage = false
        self.items = self.worker.generateDisplayCellItems(keyword: request.keyword, coins: self.coins)
        self.presenter?.performPresentCoinList(response: .init(items: self.items))

        self.worker.fetchCoins(offset: 0, keyword: request.keyword) { [weak self] coins, error in
            guard let self = self else { return }
            if let error = error {
                self.items = self.worker.generateGetCoinsErrorCellItems()
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
                self.presenter?.performPresentCoinList(response: .init(items: self.items))
            } else {
                self.coins.append(contentsOf: coins)
                if self.coins.isEmpty {
                    self.presenter?.performPresentEmptyState(response: .init())
                } else {
                    self.items = self.worker.generateDisplayCellItems(keyword: request.keyword, coins: self.coins)
                    self.presenter?.performPresentCoinList(response: .init(items: self.items))
                }
            }
            self.isLoading = false
        }
        
    }
    
    func loadMore(request: CoinListModels.LoadMore.Request) {
        guard !self.isLoading && !self.isLastPage else {
            return
        }
        self.isLoading = true
        let keyword: String = self.keyword
        
        self.items = self.worker.generateDisplayCellItems(keyword: keyword, coins: self.coins)
        self.presenter?.performPresentCoinList(response: .init(items: self.items))

        self.worker.fetchCoins(offset: self.coins.count, keyword: keyword) { [weak self] coins, error in
            guard let self = self else { return }
            if let error = error {
                self.items = self.worker.generateLoadMoreErrorCellItems(keyword: keyword, coins: self.coins)
                self.presenter?.performPresentCoinList(response: .init(items: self.items))
                self.presenter?.performPresentErrorDialog(response: .init(error: error))
            } else {
                self.isLastPage = coins.isEmpty
                self.coins.append(contentsOf: coins)
                self.items = self.worker.generateDisplayCellItems(keyword: keyword, coins: self.coins)
                self.presenter?.performPresentCoinList(response: .init(items: self.items))
            }
            self.isLoading = false
        }
    }
    
    
    func handleLoadingFooterView(request: CoinListModels.PresentFooterView.Request) {
        if self.isLastPage {
            self.presenter?.performPresentFooterView(response: .init(isHidden: true))
        } else {
            self.presenter?.performPresentFooterView(response: .init(isHidden: request.isHidden))
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
