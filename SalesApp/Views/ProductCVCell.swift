//
//  ProductCVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 21.08.2023.
//

import UIKit
import Firebase



class ProductCVCell: UICollectionViewCell {
    var product: Product?
    var viewModel: SalesViewModel?
    var ref: DatabaseReference?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBAction func addCartClicked(_ sender: Any) {
        
        if let products = product,
           let referance = ref {
            viewModel?.addBasket(product: products, ref: referance)
        }
    }
   
}
