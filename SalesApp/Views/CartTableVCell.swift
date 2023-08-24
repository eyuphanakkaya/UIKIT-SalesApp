//
//  CartTableVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 24.08.2023.
//

import UIKit

class CartTableVCell: UITableViewCell {

    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var pieceProductLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func removeClicked(_ sender: Any) {
    }
    @IBAction func increaseClicked(_ sender: Any) {
    }
    @IBAction func reduceClicked(_ sender: Any) {
    }
}
