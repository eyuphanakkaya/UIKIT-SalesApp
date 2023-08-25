//
//  ProductCVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 21.08.2023.
//

import UIKit



class ProductCVCell: UICollectionViewCell {
    var viewModel: SalesViewModel?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    
    @IBAction func addCartClicked(_ sender: Any) {
        if let viewModels = viewModel, let index = viewModels.indexPath {
            viewModels.myProtocol?.add(indexPath: index)

        }
    }
}
