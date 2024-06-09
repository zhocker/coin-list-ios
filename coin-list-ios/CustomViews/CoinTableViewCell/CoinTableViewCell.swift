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
        
    func config(coinViewModel: CoinViewModel) {
        if let url = URL(string: coinViewModel.iconUrl)  {
            coinImageView.kf.setImage(with: url)
        } else {
            coinImageView.image = nil
        }
        nameLabel.text = coinViewModel.name
        symbolLabel.text = coinViewModel.symbol
        priceLabel.text = coinViewModel.price
        changeLabel.text = coinViewModel.change
        changeLabel.textColor = UIColor.color(with: coinViewModel.changeColor)
        chanageImageView.image = UIImage(named: coinViewModel.changeIconImageName)
    }
    
}
