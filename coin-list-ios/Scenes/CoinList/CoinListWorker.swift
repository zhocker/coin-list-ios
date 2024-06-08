//
//  CoinListWorker.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit

// sourcery: AutoMockable
protocol CoinListWorkerProtocol: AnyObject {
    func doSomeCalculate() -> Int
}

class CoinListWorker: CoinListWorkerProtocol {
    
    func doSomeCalculate() -> Int {
        return 1
    }

}
