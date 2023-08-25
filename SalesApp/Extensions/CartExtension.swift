//
//  CartExtension.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 25.08.2023.
//

import Foundation
import UIKit
import Kingfisher

extension CartViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModels = viewModel?.cartList {
            return  viewModels.count
        } else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cart =  viewModel?.cartList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableVCell
        if let image = cart?.image, let title = cart?.title, let price = cart?.price {
            cell.imageViews.kf.setImage(with: URL(string: image))
            cell.productPriceLabel.text = "$\(price)"
            cell.productNameLabel.text = title
            tableView.rowHeight = 82
        }

        return cell
    }
    
}
