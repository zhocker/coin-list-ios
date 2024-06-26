//
//  CoinListWorker.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import Moya

protocol CoinListWorkerProtocol: AnyObject {
    func fetchCoins(limit: Int, offset: Int, keyword: String, completion: @escaping ([Coin], Error?) -> Void)
    func generateDisplayCellItems(keyword: String, coins: [Coin]) -> [CoinListModels.DisplayCellItem]
    func generateGetCoinsErrorCellItems() -> [CoinListModels.DisplayCellItem]
    func generateLoadMoreErrorCellItems(keyword: String, coins: [Coin]) -> [CoinListModels.DisplayCellItem]
}

class CoinListWorker: CoinListWorkerProtocol {
    
    private let provider: MoyaProvider<CoinService>
    init(provider: MoyaProvider<CoinService> = MoyaProvider<CoinService>()) {
        self.provider = provider
    }

    func fetchCoins(limit: Int, offset: Int, keyword: String = "", completion: @escaping ([Coin], Error?) -> Void) {
        provider.request(.getCoins(limit: limit, offset: offset, keyword: keyword)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(CoinsResponse.self, from: response.data)
                    guard let coins = response.data?.coins else {
                        completion([], AppError(message: "Something went wrong. Please try again."))
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
        
        var items: [CoinViewModel] = coins.map({ convertCoinToCoinViewModel(coin: $0) })
        var displayCellItems: [CoinListModels.DisplayCellItem] = []
        let topRankCoins: [CoinViewModel] = Array(items.prefix(3))
        if keyword.isEmpty && !topRankCoins.isEmpty {
            displayCellItems.append(.ranking(generateTopRankingTitle(amount: topRankCoins.count), topRankCoins))
            items = Array(items.dropFirst(topRankCoins.count))
        }
        displayCellItems.append(.title("Buy, sell and hold crypto"))
        for (index, coin) in items.enumerated() {
            displayCellItems.append(.coin(coin))
            if (index + 1) % 4 == 0 {
                displayCellItems.append(.inviteFriend(self.generateInviteFriendText()))
            }
        }
        return displayCellItems
    }
    
    func generateGetCoinsErrorCellItems() -> [CoinListModels.DisplayCellItem] {
        var displayCellItems: [CoinListModels.DisplayCellItem] = []
        displayCellItems.append(.title("Buy, sell and hold crypto"))
        displayCellItems.append(.errorGetCoins)
        return displayCellItems
    }
    
    func generateLoadMoreErrorCellItems(keyword: String, coins: [Coin]) -> [CoinListModels.DisplayCellItem] {
        var displayCellItems: [CoinListModels.DisplayCellItem] = generateDisplayCellItems(keyword: keyword, coins: coins)
        displayCellItems.append(.errorLoadMore)
        return displayCellItems
    }
    
    private func generateInviteFriendText() -> NSMutableAttributedString {
        let invitationText = "You can earn $10 when you invite a friend to buy crypto. Invite your friend"
        let attributedString = NSMutableAttributedString(string: invitationText)
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: fullRange)
        
        if let inviteRange = invitationText.range(of: "Invite your friend") {
            let nsInviteRange = NSRange(inviteRange, in: invitationText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.ciBlue, range: nsInviteRange)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: nsInviteRange)
        }
        return attributedString
    }

    private func generateTopRankingTitle(amount: Int) -> NSMutableAttributedString {
        let invitationText = "Top \(amount) rank crypto"
        let attributedString = NSMutableAttributedString(string: invitationText)
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: fullRange)
        
        if let inviteRange = invitationText.range(of: "\(amount)") {
            let nsInviteRange = NSRange(inviteRange, in: invitationText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.ciDarkRed, range: nsInviteRange)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: nsInviteRange)
        }
        return attributedString
    }
    
    private func convertCoinToCoinViewModel(coin: Coin) -> CoinViewModel {
        let formatter = CoinViewModelFormatter()
        let changeInfo = formatter.determineChangeColorAndIcon(change: coin.change)
        let displayPrice = formatter.formatPrice(from: coin)
        
        return CoinViewModel(uuid: coin.uuid ?? "",
                             name: coin.name ?? "",
                             symbol: coin.symbol ?? "",
                             iconUrl: coin.iconUrl ?? "",
                             price: displayPrice,
                             change: coin.change ?? "0.00",
                             changeColor: changeInfo.changeColor,
                             changeIconImageName: changeInfo.changeIcon)
    }
    
}
