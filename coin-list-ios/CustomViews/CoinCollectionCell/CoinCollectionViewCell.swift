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
            self.viewContainer.cornerRadius = 8
            self.shadowView.addBottomShadow()
        }
    }
        
    func config(coinViewModel: CoinViewModel) {
        if let url = URL(string: coinViewModel.iconUrl)  {
            if url.lastPathComponent.contains(".svg") {
                coinImageView.loadSVG(from: url)
            } else {
                coinImageView.kf.setImage(with: url)
            }
        } else {
            coinImageView.image = nil
        }
        nameLabel.text = coinViewModel.name
        symbolLabel.text = coinViewModel.symbol
        changeLabel.text = coinViewModel.change
        changeLabel.textColor = UIColor.color(with: coinViewModel.changeColor)
        chanageImageView.image = UIImage(named: coinViewModel.changeIconImageName)
    }

}
