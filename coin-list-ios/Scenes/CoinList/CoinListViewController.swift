//
//  CoinListViewController.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import SnapKit

protocol CoinListViewControllerDisplayLogic: AnyObject {
    func displayErrorDialog(viewModel: CoinListModels.PresentErrorDialog.ViewModel)
    func displayCoinList(viewModel: CoinListModels.GetCoinList.ViewModel)
    func displayEmptyState(viewModel: CoinListModels.PresentEmptyState.ViewModel)
}

class CoinListViewController: UIViewController {

    var interactor: CoinListInteractorBusinessLogic!
    var router: CoinListRouterRoutingLogic!
    var dataStore: CoinListInteractorDataStore!
    private let debouncer = Debouncer(interval: 0.5) // Adjust the interval as needed

    lazy var dummyView: UIView = {
        let element = UIView()
        element.backgroundColor = .white
        return element
    }()
    
    lazy var searchBar: UISearchBar = {
        let element = UISearchBar()
        element.delegate = self
        return element
    }()
    
    lazy var emptyView: UIView = {
        let element = UIView()
        element.backgroundColor = .clear
        element.isHidden = true
    
        let label = UILabel()
        label.text = "Sorry"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        element.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(element)
        }
        
        let subLabel = UILabel()
        subLabel.text = "No result match this keyword"
        subLabel.font = UIFont.systemFont(ofSize: 16)
        subLabel.textColor = UIColor.color(with: "#999999")
        element.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(element)
            make.top.equalTo(label.snp.bottom).offset(8)
        }
        
        return element
    }()

    lazy var tableView: UITableView = {
        
        let element = UITableView()
        element.separatorStyle = .none
        element.delegate = self
        element.dataSource = self
        element.refreshControl = self.refreshControl
        
        element.register(UINib(nibName: "InviteFriendTableViewCell", bundle: nil), forCellReuseIdentifier: "InviteFriendTableViewCell")
        element.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        element.register(UINib(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: "RankingTableViewCell")
        element.register(UINib(nibName: "CoinTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinTableViewCell")

        return element
        
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let element = UIRefreshControl()
        element.tintColor = .blue
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initLayoutConstraint()
        self.applyStyle()
        self.interactor.getCoinList(request: .init(keyword: self.searchBar.text ?? ""))
    }

}
// MARK: - Event Handler
private extension CoinListViewController {
    
    @objc private func refreshData() {
        self.interactor.getCoinList(request: .init(keyword: self.searchBar.text ?? ""))
    }
    
}

// MARK: - UI
private extension CoinListViewController {

    func initUI() {
        self.view.addSubview(dummyView)
        self.view.addSubview(emptyView)
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func initLayoutConstraint() {
        self.dummyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        
    }

    func applyStyle() {
        self.view.backgroundColor = .white
    }

}

// MARK: - CoinListDisplayLogic

extension CoinListViewController: CoinListViewControllerDisplayLogic {
    

    func displayErrorDialog(viewModel: CoinListModels.PresentErrorDialog.ViewModel) {
        debugPrint("Error na!")
    }

    func displayCoinList(viewModel: CoinListModels.GetCoinList.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = false
            self?.emptyView.isHidden = true
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    func displayEmptyState(viewModel: CoinListModels.PresentEmptyState.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
            self?.emptyView.isHidden = false
            self?.refreshControl.endRefreshing()
        }
    }

}

extension CoinListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.debouncer.execute { [weak self] in
            guard let self = self else { return }
            self.interactor.getCoinList(request: .init(keyword: self.searchBar.text ?? ""))
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.interactor.getCoinList(request: .init(keyword: self.searchBar.text ?? ""))
    }
    
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStore.displayCellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.dataStore.displayCellItems[indexPath.row]
        switch item {
        case .ranking(let attributedString, let coins):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath) as? RankingTableViewCell {
                cell.config(attributedString: attributedString, coins: coins)
                cell.didSelectCoin = { [weak self] coinViewModel in
                    self?.router.routeToCoinDetail(coinViewModel: coinViewModel)
                }
                return cell
            }
        case .title(let title):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell {
                cell.config(title: title)
                return cell
            }
        case .coin(let coinViewModel):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as? CoinTableViewCell {
                cell.config(coinViewModel: coinViewModel)
                return cell
            }
        case .inviteFriend(let attributedString):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "InviteFriendTableViewCell", for: indexPath) as? InviteFriendTableViewCell {
                cell.config(attributedString: attributedString)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.dataStore.displayCellItems.count - 1 {
            self.interactor?.loadMore(request: .init())
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.dataStore.displayCellItems[indexPath.row]
        switch item {
        case .ranking:
            break
        case .title:
            break
        case .coin(let coinViewModel):
            self.router.routeToCoinDetail(coinViewModel: coinViewModel)
            break
        case .inviteFriend(let attributedString):
            self.router.shareText(invitationText: attributedString.string)
            break
        }
    }
    
}

// MARK: - Private Method
private extension CoinListViewController {
    
}
