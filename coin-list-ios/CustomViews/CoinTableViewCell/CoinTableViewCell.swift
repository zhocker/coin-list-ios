//
//  CoinTableViewCell.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import Kingfisher

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var chanageImageView: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        DispatchQueue.main.async { [weak self] in
            self?.viewContainer.cornerRadius = 8
            self?.shadowView.addBottomShadow()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(coin: Coin) {
        if let iconUrl = coin.iconUrl, let url = URL(string: iconUrl)  {
            coinImageView.kf.setImage(with: url)
        } else {
            coinImageView.image = nil
        }
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceLabel.text = coin.price
        changeLabel.text = coin.change
        changeLabel.textColor = UIColor.color(with: coin.changeColor)
        chanageImageView.image = UIImage(named: coin.changeIconImageName)
        
    }
    
}
