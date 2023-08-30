//
//  ProductCVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 21.08.2023.
//

import UIKit



class ProductCVCell: UICollectionViewCell {
    var product: Product?
    var viewModel: SalesViewModel?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBAction func addCartClicked(_ sender: Any) {
if let viewModels = viewModel ,
   let fetchProduct = product ,
   let id = fetchProduct.id,
   let image = fetchProduct.thumbnail,
   let title = fetchProduct.title ,
   let price = fetchProduct.price {
    let cart = MyCart(id: id, image: image, title: title, price: price, piece: viewModels.totalProduct)
    if !viewModels.cartList.contains(where: {$0.id == cart.id}) {
        
        viewModels.cartList.append(cart)
//        viewModels.price = viewModels.price + Double(price)
        viewModels.totalPrice = viewModels.totalPrice + Double(price)
    } else {
        
        viewModels.totalProduct = viewModels.totalProduct + 1
//        viewModels.price = viewModels.price + Double(price)
        viewModels.totalPrice = viewModels.totalPrice + Double(price)

    }
    
}
        //        if let viewModels = viewModel,
        //            let index = viewModels.id
        //        {
        //            viewModels.myProtocol?.add(id: index)
        //            print(index)
        //        }
    }
}
