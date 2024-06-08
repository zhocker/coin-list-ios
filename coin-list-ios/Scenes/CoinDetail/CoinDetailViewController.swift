//
//  CoinDetailViewController.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import SnapKit

protocol CoinDetailViewControllerDisplayLogic: AnyObject {
    func displayErrorDialog(viewModel: CoinDetailModels.PresentErrorDialog.ViewModel)
}

class CoinDetailViewController: UIViewController {

    var interactor: CoinDetailInteractorBusinessLogic!
    var router: CoinDetailRouterRoutingLogic!

    lazy var dummyLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World!"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initLayoutConstraint()
        self.applyStyle()
    }

}
// MARK: - Event Handler
private extension CoinDetailViewController {}

// MARK: - UI
private extension CoinDetailViewController {

    func initUI() {
        self.view.addSubview(dummyLabel)
    }
    
    func initLayoutConstraint() {
        self.dummyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func applyStyle() {
        self.view.backgroundColor = .white
    }

}

// MARK: - CoinDetailDisplayLogic

extension CoinDetailViewController: CoinDetailViewControllerDisplayLogic {

    func displayErrorDialog(viewModel: CoinDetailModels.PresentErrorDialog.ViewModel) {
        debugPrint("Error na!")
    }

}

// MARK: - Private Method
private extension CoinDetailViewController {}
