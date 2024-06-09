//
//  CustomRefreshControl.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import UIKit
import SnapKit

class CustomRefreshControl: UIRefreshControl {
    
    lazy var loadingImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "icon-refresh")
        return element
    }()
    
    override init() {
        super.init()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(loadingImageView)
        loadingImageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.center.equalToSuperview()
        }
        self.loadingImageView.startRotating()
        addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    override func beginRefreshing() {
        super.beginRefreshing()
        self.loadingImageView.startRotating()
    }

    override func endRefreshing() {
        super.endRefreshing()
    }

    @objc private func refresh() {
        self.loadingImageView.startRotating()
    }

}
