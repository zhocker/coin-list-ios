//
//  ErrorTableViewCell.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    var callback: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tryAgainButtonAction(_ sender: Any) {
        callback?()
    }
}
