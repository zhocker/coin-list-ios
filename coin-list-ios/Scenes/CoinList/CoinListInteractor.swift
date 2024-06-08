//
//  CoinListInteractor.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol CoinListInteractorBusinessLogic: AnyObject {}

// sourcery: AutoMockable
protocol CoinListInteractorDataStore: AnyObject {}

// MARK: - Interactor
class CoinListInteractor: CoinListInteractorBusinessLogic {
    var presenter: CoinListPresentationLogic?
    var worker = CoinListWorker()
}

// MARK: - Private functions
private extension CoinListInteractor {

}

// MARK: - Data Store
extension CoinListInteractor: CoinListInteractorDataStore {

}