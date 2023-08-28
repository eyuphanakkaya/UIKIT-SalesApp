//
//  CartTableVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 24.08.2023.
//

import UIKit

class CartTableVCell: UITableViewCell {
    var viewModel: SalesViewModel?
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var pieceProductLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
 
        if let total = viewModel?.totalProduct {
            pieceProductLabel.text = "\(total)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

    @IBAction func removeClicked(_ sender: Any) {
        
    }
    @IBAction func increaseClicked(_ sender: Any) {
        if var total = viewModel?.totalProduct {
           total = total + 1
        }
        print("artı")
    }
    @IBAction func reduceClicked(_ sender: Any) {
        if var total = viewModel?.totalProduct {
           total = total - 1
        }
        print("eksi")
    }
}
