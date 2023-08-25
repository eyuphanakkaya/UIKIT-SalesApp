//
//  CateExtension.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import Foundation
import UIKit
import Kingfisher

extension CateViewController: UICollectionViewDataSource,UICollectionViewDelegate,ProductProtocol {
    func add(indexPath: IndexPath) {
        let indexPath = productsList[indexPath.row]
        if let viewModels = viewModel, let image = indexPath.thumbnail, let title = indexPath.title, let price = indexPath.price {
            let products = MyCart(image: image, title: title, price: price)
            viewModels.cartList.append(products)
            print("Sepete Ekle: \(viewModels.cartList)")
        }
     
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cate = productsList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cateCell2", for: indexPath) as! CategoriesCVCell
        
        cell.imageView.kf.setImage(with: URL(string: cate.thumbnail ?? ""))
        cell.productTitleLabel.text = cate.title ?? ""
        cell.priceLabel.text = "$\(cate.price ?? 0)"
        cell.viewModel = viewModel
        cell.viewModel?.indexPath = indexPath
        cell.viewModel?.myProtocol = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    
}
