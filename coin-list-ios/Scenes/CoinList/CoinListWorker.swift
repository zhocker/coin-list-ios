//
//  CoinListWorker.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import Moya

// sourcery: AutoMockable
protocol CoinListWorkerProtocol: AnyObject {
    func fetchCoins(limit: Int, offset: Int, keyword: String, completion: @escaping ([Coin], Error?) -> Void)
    func generateDisplayCellItems(keyword: String, coins: [Coin]) -> [CoinListModels.DisplayCellItem]
}

class CoinListWorker: CoinListWorkerProtocol {
    
    private let provider = MoyaProvider<CoinService>()

    func fetchCoins(limit: Int = 10, offset: Int, keyword: String = "", completion: @escaping ([Coin], Error?) -> Void) {
        provider.request(.getCoins(limit: limit, offset: offset, keyword: keyword)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(CoinsResponse.self, from: response.data)
                    guard let coins = response.data?.coins else {
                        completion([], nil)
                        return
                    }
                    completion(coins, nil)
                } catch {
                    completion([], error)
                }
            case .failure(let error):
                completion([], error)
            }
        }
    }
    
    func generateDisplayCellItems(keyword: String, coins: [Coin]) -> [CoinListModels.DisplayCellItem] {
        guard !coins.isEmpty else {
            return []
        }
        
        var items: [Coin] = coins
        var displayCellItems: [CoinListModels.DisplayCellItem] = []
        let topRankCoins: [Coin] = Array(items.prefix(3))
        if keyword.isEmpty && !topRankCoins.isEmpty {
            displayCellItems.append(.ranking(topRankCoins))
            items = Array(items.dropFirst(topRankCoins.count))
        }
        displayCellItems.append(.title("Buy, sell and hold crypto"))
        for (index, coin) in items.enumerated() {
            displayCellItems.append(.coin(coin))
            if (index + 1) % 4 == 0 {
                displayCellItems.append(.inviteFriend)
            }
        }
        return displayCellItems
    }

}
