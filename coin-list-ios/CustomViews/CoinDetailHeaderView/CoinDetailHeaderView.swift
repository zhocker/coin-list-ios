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
    
    func config(coinViewModel: CoinViewModel) {
        if let url = URL(string: coinViewModel.iconUrl)  {
            coinImageView.kf.setImage(with: url)
        } else {
            coinImageView.image = nil
        }
        nameLabel.text = coinViewModel.name
        symbolLabel.text = "(\(coinViewModel.symbol))"
        priceLabel.text = coinViewModel.price
    }

    func config(coinDetailViewModel: CoinDetailViewModel) {
        if let url = URL(string: coinDetailViewModel.iconUrl)  {
            coinImageView.kf.setImage(with: url)
        } else {
            coinImageView.image = nil
        }
        nameLabel.text = coinDetailViewModel.name
        symbolLabel.text = "(\(coinDetailViewModel.symbol))"
        priceLabel.text = coinDetailViewModel.price
        marketCapLabel.text = coinDetailViewModel.marketCap
    }
    
}
