//
//  SearchExtension.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 2.09.2023.
//

import Foundation
import UIKit
import Kingfisher

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = productList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCVCell
        cell?.imageView.kf.setImage(with: URL(string: product.thumbnail ?? ""))
        cell?.priceLabel.text = "$\(product.price ?? 0)"
        cell?.productNameLabel.text = product.title

        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        performSegue(withIdentifier: "toSearchDetail", sender: product.id)
    }
}
