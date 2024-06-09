//
//  CoinDetailInteractor.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

protocol CoinDetailInteractorBusinessLogic: AnyObject {}

protocol CoinDetailInteractorDataStore: AnyObject {
    var displayCoin: Coin? { get set }
}

// MARK: - Interactor
class CoinDetailInteractor: CoinDetailInteractorBusinessLogic, CoinDetailInteractorDataStore {
    var presenter: CoinDetailPresentationLogic?
    var worker = CoinDetailWorker()
    var displayCoin: Coin? = nil
}

// MARK: - Private functions
private extension CoinDetailInteractor {

}
