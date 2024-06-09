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
    
    enum ShareSocial {
        
        struct Request {

        }
        
        struct Response {

        }
        
        struct ViewModel {

        }
        
    }

    
    enum PresentErrorDialog {
        
        struct Request {
            
        }

        struct Response {
            var error: Error?
        }

        struct ViewModel {
            var title: String?
            var message: String
        }
    }

    enum PresentEmptyState {
        
        struct Request {
            
        }

        struct Response {
            var error: Error?
        }

        struct ViewModel {
            var title: String?
            var message: String
        }
        
    }

}


