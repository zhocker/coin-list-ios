//
//  InviteFriendTableViewCell.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit

class InviteFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func config(string: String) {
        self.titleLabel.text = string
    }
    
    func config(attributedString: NSAttributedString) {
        self.titleLabel.attributedText = attributedString
    }
    
}
