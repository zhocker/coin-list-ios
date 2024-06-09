//
//  CoinDetailHeaderView.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import UIKit
import SnapKit
import Kingfisher

class CoinDetailHeaderView: UIView {
    
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "CoinDetailHeaderView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
    }
    
    func config(coin: Coin) {
        if let iconUrl = coin.iconUrl, let url = URL(string: iconUrl)  {
            coinImageView.kf.setImage(with: url)
        }
        nameLabel.text = coin.name
        if let symbol = coin.symbol {
            symbolLabel.text = "(\(symbol))"
        } else {
            symbolLabel.text = ""
        }
        priceLabel.text = coin.price
        marketCapLabel.text = coin.marketCap
    }

}
