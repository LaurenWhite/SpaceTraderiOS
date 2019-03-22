//
//  TradeItemCell.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 3/19/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation
import UIKit

class TradeItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func decorate(name: String, price: Int, quantity: Int) {
        nameLabel.text = name
        priceLabel.text = "$\(price)"
        quantityLabel.text = String(quantity)
    }
    
    func normalStyle() {
        nameLabel.textColor = UIColor(red: 118/255, green: 214/255, blue: 255/255, alpha: 1)
        priceLabel.textColor = UIColor(red: 118/255, green: 214/255, blue: 255/255, alpha: 1)
        quantityLabel.textColor = UIColor(red: 118/255, green: 214/255, blue: 255/255, alpha: 1)
    }
    
    func disabledStyle() {
        nameLabel.textColor = UIColor.darkGray
        priceLabel.textColor = UIColor.darkGray
        quantityLabel.textColor = UIColor.darkGray
    }
    
}
