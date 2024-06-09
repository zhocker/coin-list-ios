//
//  CoinCollectionViewCell.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import Kingfisher

class CoinCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var chanageImageView: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let viewContainer = self.viewContainer else { return }
            guard let shadowView = self.shadowView else { return }
            viewContainer.cornerRadius = 8
            shadowView.addBottomShadow()
        }
    }
    
    func config(coin: Coin) {
        if let iconUrl = coin.iconUrl, let url = URL(string: iconUrl)  {
            coinImageView.kf.setImage(with: url)
        } else {
            coinImageView.image = nil
        }
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        changeLabel.text = coin.change
        changeLabel.textColor = UIColor.color(with: coin.changeColor)
        chanageImageView.image = UIImage(named: coin.changeIconImageName)
        
    }

}
