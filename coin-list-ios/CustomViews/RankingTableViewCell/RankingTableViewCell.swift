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
    private var coins: [CoinViewModel] = []
    var didSelectCoin: ((CoinViewModel) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CoinCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoinCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(attributedString: NSAttributedString, coins: [CoinViewModel]) {
        self.rankingLabel.attributedText = attributedString
        self.coins = coins
        self.collectionView.reloadData()
    }

}

extension RankingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionViewCell", for: indexPath) as! CoinCollectionViewCell
        let coin = self.coins[indexPath.row]
        cell.config(coinViewModel: coin)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let availableWidth = collectionView.frame.width - (padding * 4)
        let widthPerItem = availableWidth / 3
        let aspectRatio: CGFloat = 144.00/110.00

        return CGSize(width: widthPerItem, height: widthPerItem * aspectRatio)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coin = self.coins[indexPath.row]
        self.didSelectCoin?(coin)
    }
    
}
