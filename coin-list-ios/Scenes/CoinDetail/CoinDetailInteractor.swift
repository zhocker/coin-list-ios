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
    var coinViewModel: CoinViewModel? { get set }
}

// MARK: - Interactor
class CoinDetailInteractor: CoinDetailInteractorBusinessLogic, CoinDetailInteractorDataStore {
    var presenter: CoinDetailPresentationLogic?
    var worker = CoinDetailWorker()
    var coinViewModel: CoinViewModel? = nil
}

// MARK: - Private functions
private extension CoinDetailInteractor {

}
