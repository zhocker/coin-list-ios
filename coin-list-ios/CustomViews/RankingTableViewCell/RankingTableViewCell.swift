//
//  RankingTableViewCell.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
