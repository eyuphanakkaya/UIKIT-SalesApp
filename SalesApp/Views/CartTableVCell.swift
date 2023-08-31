//
//  CartTableVCell.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 24.08.2023.
//

import UIKit
import Firebase

class CartTableVCell: UITableViewCell {
    var viewModel: SalesViewModel?
    var product: Product?
    var ref: DatabaseReference?
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
        artı()
        print("artı")
    }
    @IBAction func reduceClicked(_ sender: Any) {
        eksilt()
        print("eksi")
    }
    func eksilt() {
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
                        updatedPiece -= existingPieceCount
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
                print("bir şey yok")
                
            }
        })
        
    }
    func artı() {
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
                print("bir şey yok")
                
            }
        })
        
    }
}
