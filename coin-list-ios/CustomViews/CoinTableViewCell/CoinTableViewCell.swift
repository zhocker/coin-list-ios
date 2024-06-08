//
//  CoinTableViewCell.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit
import SDWebImage

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var chanageImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(coin: Coin) {
        if let iconUrl = coin.iconUrl {
            coinImageView.sd_setImage(with: URL(string: iconUrl))
        }
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceLabel.text = coin.price
        changeLabel.text = coin.change
        chanageImageView.image = nil
    }
    
}
