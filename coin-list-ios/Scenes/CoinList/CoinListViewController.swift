//
//  CoinListViewController.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import SnapKit

// sourcery: AutoMockable
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
    
    lazy var searhBar: UISearchBar = {
        let element = UISearchBar()
        element.delegate = self
        return element
    }()

    lazy var tableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .none
        element.delegate = self
        element.dataSource = self
        element.refreshControl = self.refreshControl

        element.register(UITableViewCell.self, forCellReuseIdentifier: "AdCell")
        element.register(UITableViewCell.self, forCellReuseIdentifier: "TitleCell")
        element.register(UITableViewCell.self, forCellReuseIdentifier: "InviteFriendCell")
        
        
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
        self.interactor.getCoinList(request: .init(keyword: self.searhBar.text ?? ""))
    }

}
// MARK: - Event Handler
private extension CoinListViewController {
    
    @objc private func refreshData() {
        self.interactor.getCoinList(request: .init(keyword: self.searhBar.text ?? ""))
    }
    
}

// MARK: - UI
private extension CoinListViewController {

    func initUI() {
        self.view.addSubview(dummyView)
        self.view.addSubview(searhBar)
        self.view.addSubview(tableView)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func initLayoutConstraint() {
        self.dummyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        self.searhBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.searhBar.snp.bottom)
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
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    func displayEmptyState(viewModel: CoinListModels.PresentEmptyState.ViewModel) {
        
    }

}

extension CoinListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.debouncer.execute { [weak self] in
            guard let self = self else { return }
            self.interactor.getCoinList(request: .init(keyword: self.searhBar.text ?? ""))
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.interactor.getCoinList(request: .init(keyword: self.searhBar.text ?? ""))
    }
    
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStore.displayCellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.dataStore.displayCellItems[indexPath.row]
        switch item {
        case .ranking(let coins):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath) as? RankingTableViewCell {
                return cell
            }
        case .title(let title):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell {
                cell.config(title: title)
                return cell
            }
        case .coin(let coin):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as? CoinTableViewCell {
                cell.config(coin: coin)
                return cell
            }
        case .inviteFriend:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InviteFriendCell", for: indexPath)
            cell.textLabel?.text = "Invite a Friend"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.dataStore.displayCellItems.count - 1 {
            self.interactor?.loadMore(request: .init())
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - Private Method
private extension CoinListViewController {
    
}
