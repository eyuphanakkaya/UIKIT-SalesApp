//
//  CategoriesCVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit
import Firebase

class CategoriesCVCell: UICollectionViewCell {
    var viewModel: SalesViewModel?
    var product: Product?
    var ref: DatabaseReference?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBAction func addCartClicked(_ sender: Any) {
        if let id = product?.id ,
           let image = product?.thumbnail ,
           let title = product?.title ,
           let price = product?.price ,
           let view = viewModel {
            let cart = MyCart(id: id, image: image, title: title, price: price,piece: 1)
            if !view.cartList.contains(where: {$0.id == product?.id }) {
                let dict: [String:Any] = ["id": cart.id,"image":cart.image,"title":cart.title,"price":cart.price,"piece":cart.piece]
                let newRef = ref?.child("MyCart").childByAutoId()
                newRef?.setValue(dict)
                
                print("eklendi")
            }
        }

       
    }
    
}
