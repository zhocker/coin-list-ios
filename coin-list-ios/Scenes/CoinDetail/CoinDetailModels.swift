//
//  CoinDetailModels.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

enum CoinDetailModels {
    
    enum GetCoinDetail {
        struct Request {
            var coinId: String
        }
        
        struct Response {
            var coin: Coin
        }
        
        struct ViewModel {
            var coin: CoinViewModel
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
