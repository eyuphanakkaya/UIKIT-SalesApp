//
//  CategoriesCVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit

class CategoriesCVCell: UICollectionViewCell {
    var viewModel: SalesViewModel?
    var product: Product?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBAction func addCartClicked(_ sender: Any) {
        if let viewModels = viewModel ,
           let fetchProduct = product ,
           let id = fetchProduct.id,
           let image = fetchProduct.thumbnail,
           let title = fetchProduct.title ,
           let price = fetchProduct.price {
            let cart = MyCart(id: id, image: image, title: title, price: price)
            if !viewModels.cartList.contains(where: {$0.id == cart.id}) {
                viewModels.cartList.append(cart)
                viewModels.totalPrice = viewModels.totalPrice + Double(price)
            }
        
        }
//        if let viewModels = viewModel, let index = viewModel?.id {
//            viewModels.myProtocol?.add(id: index)
//            print(index)
//        }
       
    }
    
}
