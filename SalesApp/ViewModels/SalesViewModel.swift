//
//  SalesViewModel.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 22.08.2023.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn


class callApi {
    static let api = "https://dummyjson.com/"
}
class SalesViewModel {

    var productList = [Product]()
    var favList = [MyFav]()
    var favLists = [MyFav]()
    var cartList = [MyCart]()
    

    
    func fetchProduct() {
        Task {
            try await  getAllProduct { product in
                    self.productList.append(contentsOf: product)
            }
        }
        
    }
    func getAllProduct(completion: @escaping([Product])->Void) async throws {
        guard let url = URL(string: "\(callApi.api)products") else {
            print("HATAAA!!!")
            return
        }
        let data: (Data,URLResponse) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductResult.self, from: data.0)
        if let results = result.products {
            completion(results)
        }
        
    }
    func getAllCate(completion: @escaping([String])-> Void) async throws {
        guard let url = URL(string: "\(callApi.api)products/categories") else{
            print("Hata")
            return
        }
        let data = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([String].self, from: data.0)
        completion(result)
        
    }
    func fetchCate(find: String,completion: @escaping([Product])->Void) async throws {
        guard let url = URL(string: "\(callApi.api)products/category/\(find)") else{
            print("Hata")
            return
        }
      let data = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductResult.self, from: data.0)
        if let results = result.products {
            completion(results)
        }
    }
    func searchProduct(search: String,completion: @escaping([Product])->Void) async throws {
        guard let url = URL(string: "https://dummyjson.com/products/search?q=\(search)") else {
            print("Hata")
            return
        }
        let data = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductResult.self, from: data.0)
        if let results = result.products {
            completion(results)
        }
        
    }
    func addBasket(product: Product,ref: DatabaseReference) {
        guard let id = product.id ,
              let image = product.thumbnail,
              let price = product.price,
              let title = product.title else{
            return
        }
        let cart = MyCart(id: id, image: image, title: title, price: price,piece: 1)
        
        ref.child("MyCart").queryOrdered(byChild: "id").queryEqual(toValue: cart.id).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                if let cartDict = snapshot.value as? [String: Any],
                   let cartId = cartDict.keys.first {
                    var updatedPiece = cart.piece
                    if let existingPiece = cartDict[cartId] as? [String: Any],
                       let existingPieceCount = existingPiece["piece"] as? Int {
                        updatedPiece += existingPieceCount
                    }
                    let updateDict: [String: Any] = ["piece": updatedPiece]
                    ref.child("MyCart").child(cartId).updateChildValues(updateDict) { error, _ in
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
                let newRef = ref.child("MyCart").childByAutoId()
                newRef.setValue(dict)
                
                print("eklendi")
                
            }
        })
        
    }
    



}
