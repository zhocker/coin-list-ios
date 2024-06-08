//
//  CoinDetailWorker.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit

// sourcery: AutoMockable
protocol CoinDetailWorkerProtocol: AnyObject {
    func doSomeCalculate() -> Int
}

class CoinDetailWorker: CoinDetailWorkerProtocol {
    
    func doSomeCalculate() -> Int {
        return 1
    }

}
