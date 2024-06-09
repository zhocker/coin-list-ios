//
//  LoadMoreFooterView.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import UIKit
import SnapKit

class LoadMoreFooterView: UIView {
    
    override var isHidden: Bool {
        didSet {
            if isHidden {
                loadingImageView.stopRotating()
            } else {
                loadingImageView.startRotating()
            }
        }
    }
    
    lazy var loadingImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "icon-loading-footer")
        return element
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(loadingImageView)
        loadingImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.center.equalToSuperview()
        }
    }
    
}


