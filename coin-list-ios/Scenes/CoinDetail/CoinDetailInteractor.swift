//
//  CoinDetailInteractor.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

protocol CoinDetailInteractorBusinessLogic: AnyObject {}

protocol CoinDetailInteractorDataStore: AnyObject {}

// MARK: - Interactor
class CoinDetailInteractor: CoinDetailInteractorBusinessLogic {
    var presenter: CoinDetailPresentationLogic?
    var worker = CoinDetailWorker()
}

// MARK: - Private functions
private extension CoinDetailInteractor {

}

// MARK: - Data Store
extension CoinDetailInteractor: CoinDetailInteractorDataStore {

}
