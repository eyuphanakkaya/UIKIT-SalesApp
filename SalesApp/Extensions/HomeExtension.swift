//
//  HomeExtentions.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 22.08.2023.
//

import Foundation
import UIKit
import Kingfisher

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
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
        } else {
            return cateList.count
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
            
            return cell!
        } else {
            let cate = cateList[indexPath.row]
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cateCell", for: indexPath) as? CategoryCVCell
            cell?.categoryNameLabel.text = cate.uppercased()
            switch cate {
            case "smartphones":
                cell?.imageView.image = UIImage(named: "resim2")
            case "laptops":
                cell?.imageView.image = UIImage(named: "resim1")
            case "laptops":
                cell?.imageView.image = UIImage(named: "resim1")
            case "laptops":
                cell?.imageView.image = UIImage(named: "resim1")
            case "laptops":
                cell?.imageView.image = UIImage(named: "resim1")
            case "laptops":
                cell?.imageView.image = UIImage(named: "resim1")
            case "laptops":
                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
//            case "laptops":
//                cell?.imageView.image = UIImage(named: "resim1")
            default:
                print("")
            }
            
            return cell!
        }
    }
}
