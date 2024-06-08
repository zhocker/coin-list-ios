//
//  CoinDetailModels.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

enum CoinDetailModels {
    
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
