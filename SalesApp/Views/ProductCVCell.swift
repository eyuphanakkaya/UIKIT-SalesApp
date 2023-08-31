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
        
        addBasket()
    }
    func addBasket() {
        guard let id = product?.id ,
              let image = product?.thumbnail,
              let price = product?.price,
              let title = product?.title else{
            return
        }
        let cart = MyCart(id: id, image: image, title: title, price: price,piece: 1)
        
        ref?.child("MyCart").queryOrdered(byChild: "id").queryEqual(toValue: cart.id).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                if let cartDict = snapshot.value as? [String: Any],
                   let cartId = cartDict.keys.first {
                    var updatedPiece = cart.piece
                    if let existingPiece = cartDict[cartId] as? [String: Any],
                       let existingPieceCount = existingPiece["piece"] as? Int {
                        updatedPiece += existingPieceCount
                    }
                    let updateDict: [String: Any] = ["piece": updatedPiece]
                    self.ref?.child("MyCart").child(cartId).updateChildValues(updateDict) { error, _ in
                        if let error = error {
                            print("Güncelleme hatası: \(error.localizedDescription)")
                        } else {
                            print("Ürün güncellendi")
                        }
                    }
                }
                
                print("ürün zaten var ")
            } else {
                let dict: [String:Any] = ["id": id,"image":image,"title":cart.title,"price":cart.price,"piece":cart.piece]
                let newRef = self.ref?.child("MyCart").childByAutoId()
                newRef?.setValue(dict)
                
                print("eklendi")
                
            }
        })
        
    }
}
