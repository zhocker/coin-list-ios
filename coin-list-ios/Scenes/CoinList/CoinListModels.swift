//
//  CoinListModels.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

enum CoinListModels {
    
    enum GetCoinList {
        struct Request {}
        
        struct Response {
            var coins: [Coin]?
        }
        
        struct ViewModel {
            var coins: [Coin]?
        }
    }
    
    enum PresentErrorDialog {
        struct Request {}

        struct Response {
            var error: Error?
        }

        struct ViewModel {
            var title: String?
            var message: String
        }
    }

}
