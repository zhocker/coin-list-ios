//
//  CoinDetailViewController.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import SnapKit
import Kingfisher

protocol CoinDetailViewControllerDisplayLogic: AnyObject {
    func displayErrorDialog(viewModel: CoinDetailModels.PresentErrorDialog.ViewModel)
}

class CoinDetailViewController: UIViewController {
    
    var interactor: CoinDetailInteractorBusinessLogic!
    var router: CoinDetailRouterRoutingLogic!
    var dataStore: CoinDetailInteractorDataStore!
    
    lazy var viewContainer: UIView = {
        let element = UIView()
        element.backgroundColor = .white
        element.clipsToBounds = true
        element.cornerRadius = 20
        return element
    }()

    lazy var headerView: CoinDetailHeaderView = {
        let element = CoinDetailHeaderView()
        return element
    }()
    
    lazy var contentLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 14)
        element.numberOfLines = 0
        return element
    }()
    
    lazy var lineView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor.color(with: "#EEEEEE")
        return element
    }()
    
    lazy var websiteButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("GO TO WEBSITE", for: .normal)
        element.setTitleColor(.systemBlue, for: .normal)
        element.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
        return element
    }()
    
    lazy var stackView: UIStackView = {
        let element = UIStackView(arrangedSubviews: [headerView, contentLabel, lineView, websiteButton])
        element.axis = .vertical
        element.spacing = 16
        element.alignment = .fill
        element.distribution = .equalSpacing
        element.backgroundColor = .clear
        element.clipsToBounds = true
        element.cornerRadius = 20
        return element
    }()
    
    lazy var closeButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setImage(UIImage(named: "icon-close"), for: .normal)
        element.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return element
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initLayoutConstraint()
        self.applyStyle()
        self.bindData(coinViewModel: self.dataStore.coinViewModel)
    }
    
}
// MARK: - Event Handler
private extension CoinDetailViewController {
    
    @objc private func websiteButtonTapped() {
        if let url = URL(string: self.dataStore.coinViewModel?.iconUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
}

// MARK: - UI
private extension CoinDetailViewController {

    func initUI() {
        self.view.addSubview(viewContainer)
        self.view.addSubview(stackView)
        self.view.addSubview(closeButton)
    }
    
    func initLayoutConstraint() {
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.top).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        viewContainer.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top).offset(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(100)
        }

        stackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(92)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }

        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        
        websiteButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
    }

    func applyStyle() {
        self.view.backgroundColor = .clear
    }
    
    func bindData(coinViewModel: CoinViewModel?) {
        guard let coinViewModel = coinViewModel else { return }
        self.headerView.config(coinViewModel: coinViewModel)
        self.contentLabel.text = """
Bitcoin is the first digital currency that allows users to send and receive money, without the interference of a central bank or government. Instead, a network of thousands of peers is controlling the transactions; a decentralized system Why does bitcoin have  Bitcoin is the first digital currency that allows users to send and receive money, without the interference of a central bank or government. Instead, a network of thousands of peers is controlling the transactions; a decentralized system Why does bitcoin have Bitcoin is the first digital currency that allows users to send and receive money, without the interference of a central bank or government. Instead, a network of thousands of peers is controlling the transactions; a decentralized system Why does bitcoin have Bitcoin is the first digital currency that allows users to send and receive money, without the interference of a central bank or government. Instead, a network of thousands of peers is controlling the transactions; a decentralized system Why does bitcoin have Bitcoin is the first digital currency that allows users to send and receive money, without the interference of a central bank or government. Instead, a network of thousands of peers is controlling the transactions
"""
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
