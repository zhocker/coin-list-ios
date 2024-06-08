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
}

class CoinListViewController: UIViewController {

    var interactor: CoinListInteractorBusinessLogic!
    var router: CoinListRouterRoutingLogic!

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
        element.delegate = self
        element.dataSource = self
        
        element.register(UITableViewCell.self, forCellReuseIdentifier: "RankingCell")
        element.register(UITableViewCell.self, forCellReuseIdentifier: "CoinCell")
        element.register(UITableViewCell.self, forCellReuseIdentifier: "AdCell")
        
        element.refreshControl = self.refreshControl
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
    }

}
// MARK: - Event Handler
private extension CoinListViewController {}

// MARK: - UI
private extension CoinListViewController {

    func initUI() {
        self.view.addSubview(dummyView)
        self.view.addSubview(searhBar)
        self.view.addSubview(tableView)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func initLayoutConstraint() {
        self.dummyLabel.snp.makeConstraints { make in
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
    
    @objc private func refreshData() {

    }

}

// MARK: - CoinListDisplayLogic

extension CoinListViewController: CoinListViewControllerDisplayLogic {

    func displayErrorDialog(viewModel: CoinListModels.PresentErrorDialog.ViewModel) {
        debugPrint("Error na!")
    }

}

extension CoinListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searhBar.resignFirstResponder()
    }
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - Private Method
private extension CoinListViewController {
    
}
