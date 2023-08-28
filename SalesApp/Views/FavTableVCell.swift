//
//  FavTableVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 28.08.2023.
//

import UIKit

class FavTableVCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageViews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favClicked(_ sender: Any) {
    }
    
}
