//
//  CoinListModels.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

enum CoinListModels {
    
    enum DisplayCellItem {
        case ranking(NSAttributedString, [CoinViewModel])
        case title(String)
        case coin(CoinViewModel)
        case inviteFriend(NSAttributedString)
        case errorGetCoins
        case errorLoadMore
    }

    enum GetCoinList {
        
        struct Request {
            var keyword: String
        }
        
        struct Response {
            var items: [DisplayCellItem]
        }
        
        struct ViewModel {
            var items: [DisplayCellItem]
        }
        
    }
    
    enum LoadMore {
        
        struct Request {

        }
        
        struct Response {
            var items: [DisplayCellItem]
        }
        
        struct ViewModel {
            var items: [DisplayCellItem]
        }
        
    }
    
    enum PresentErrorDialog {

        struct Response {
            var error: Error?
        }

        struct ViewModel {
            var title: String?
            var message: String
        }
        
    }

    enum PresentEmptyState {

        struct Response {

        }

        struct ViewModel {

        }
        
    }

    enum PresentFooterView {
        
        struct Request {
            let isHidden: Bool
        }

        struct Response {
            let isHidden: Bool
        }

        struct ViewModel {
            let isHidden: Bool
        }
        
    }

}


