//
//  AllcateTableVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 30.08.2023.
//

import UIKit

class AllCateTableVCell: UITableViewCell {

    @IBOutlet weak var cateNameLabel: UILabel!
    @IBOutlet weak var imageViews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
