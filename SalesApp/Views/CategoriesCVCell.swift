//
//  CategoriesCVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit

class CategoriesCVCell: UICollectionViewCell {
    var viewModel: SalesViewModel?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBAction func addCartClicked(_ sender: Any) {
        if let viewModels = viewModel, let index = viewModels.indexPath {
            viewModels.myProtocol?.add(indexPath: index)
        }
    }
    
}
