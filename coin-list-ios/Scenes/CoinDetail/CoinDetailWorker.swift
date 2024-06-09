//
//  CoinDetailWorker.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import Moya

protocol CoinDetailWorkerProtocol: AnyObject {
    func fetchCoinDetail(uuid: String, completion: @escaping (CoinDetail?, Error?) -> Void)
    func convertCoinToCoinViewModel(coin: CoinDetail) -> CoinDetailViewModel
}

class CoinDetailWorker: CoinDetailWorkerProtocol {
    
    private let provider = MoyaProvider<CoinService>()
    
    func fetchCoinDetail(uuid: String, completion: @escaping (CoinDetail?, Error?) -> Void) {
        
        provider.request(.getCoinDetail(uuid: uuid)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(CoinDetailResponse.self, from: response.data)
                    guard let coins = response.data?.coin else {
                        completion(nil, nil)
                        return
                    }
                    completion(coins, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func convertCoinToCoinViewModel(coin: CoinDetail) -> CoinDetailViewModel {
        let formatter = CoinViewModelFormatter()
        let displayPrice = formatter.formatPrice(from: coin)
        let displayMarketCap = formatter.formatMarketCap(from: coin)

        return CoinDetailViewModel(uuid: coin.uuid ?? "",
                                   name: coin.name ?? "",
                                   symbol: coin.symbol ?? "",
                                   iconUrl: coin.iconUrl ?? "",
                                   price: displayPrice,
                                   description: coin.description ?? "",
                                   marketCap: displayMarketCap,
                                   websiteUrl: coin.websiteUrl ?? "https://coinranking.com/")
    }


}
