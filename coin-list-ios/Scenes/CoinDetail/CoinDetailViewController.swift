//
//  CoinDetailViewController.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import SnapKit
import Kingfisher
import Toast_Swift

protocol CoinDetailViewControllerDisplayLogic: AnyObject {
    func displayErrorDialog(viewModel: CoinDetailModels.PresentErrorDialog.ViewModel)
    func displayCoinDetail(viewModel: CoinDetailModels.GetCoinDetail.ViewModel)
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
        element.isHidden = true
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
        self.bindDefaultData(coinViewModel: self.dataStore.coinViewModel)
        if let uuid = self.dataStore.coinViewModel?.uuid {
            self.interactor.getCoinDetail(request: .init(uuid: uuid))
        }
    }
    
}
// MARK: - Event Handler
private extension CoinDetailViewController {
    
    @objc private func websiteButtonTapped() {
        if let url = URL(string: self.dataStore.websiteUrl) {
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
    
}

// MARK: - CoinDetailDisplayLogic

extension CoinDetailViewController: CoinDetailViewControllerDisplayLogic {
    
    private func bindDefaultData(coinViewModel: CoinViewModel?) {
        guard let coinViewModel = coinViewModel else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.headerView.config(coinViewModel: coinViewModel)
            self.contentLabel.text = ""
        }
    }

    func displayErrorDialog(viewModel: CoinDetailModels.PresentErrorDialog.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.makeToast("\(viewModel.message)", duration: 2.0, position: .bottom)
        }
    }
    
    func displayCoinDetail(viewModel: CoinDetailModels.GetCoinDetail.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.headerView.config(coinDetailViewModel: viewModel.coin)
            self.contentLabel.text = viewModel.coin.description
            self.websiteButton.isHidden = false
        }
    }

}

// MARK: - Private Method
private extension CoinDetailViewController {}
