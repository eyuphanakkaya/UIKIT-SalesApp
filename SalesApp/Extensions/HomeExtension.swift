//
//  HomeExtentions.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 22.08.2023.
//

import Foundation
import UIKit
import Kingfisher

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,ProductProtocol {
    func add(indexPath: IndexPath) {
        let indexPath = productList[indexPath.row]
        if let image = indexPath.thumbnail , let title = indexPath.title , let price = indexPath.price {
            let products = MyCart(image: image, title: title, price: price)
            
            viewModel.cartList.append(products)
            print("Sepete Ekle: \(viewModel.cartList)")
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.homeCollectionView {
            return 2
        } else if collectionView == self.productCollectionView {
            return 1
        } else {
            return 1
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.homeCollectionView {
            return 1
        } else if collectionView == self.productCollectionView {
            return productList.count
       //     return productList.prefix(10).count
        } else {
            return cateList.prefix(4).count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.homeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            cell?.imageView.image = UIImage(named: "resim1")
            return cell!
        } else if collectionView == self.productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCVCell
            let product = productList[indexPath.row]
            if let image = product.thumbnail ,
               let title = product.title,
               let price = product.price {
                cell?.imageView.kf.setImage(with: URL(string: image))
                cell?.productName.text =  title
                cell?.productPrice.text = "$\(price)"
            }
            cell?.viewModel = viewModel
            cell?.viewModel?.indexPath = indexPath
            cell?.viewModel?.myProtocol = self
            return cell!
        } else {
            let cate = cateList[indexPath.row]
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cateCell", for: indexPath) as? CategoryCVCell
            cell?.categoryNameLabel.text = cate.uppercased()
            switch cate {
            case "smartphones":
                cell?.imageView.image = UIImage(named: "phone")
            case "laptops":
                cell?.imageView.image = UIImage(named: "laptop")
            case "fragrances":
                cell?.imageView.image = UIImage(named: "fragrances")
            case "skincare":
                cell?.imageView.image = UIImage(named: "skincare")
            default:
                print("")
            }
            return cell!
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCollectionView {
            performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
            
        } else if collectionView == cateCollectionView {
            performSegue(withIdentifier: "toCateVC", sender: indexPath.row)
        }
    }
}

