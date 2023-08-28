//
//  FavExtension.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 28.08.2023.
//

import Foundation
import UIKit
import Kingfisher


extension FavViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  viewModel?.favList.count ?? 0
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fav = viewModel?.favList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavTableVCell
        if let favori = fav?.image,
           let title = fav?.title,
           let price = fav?.price
        {
            cell.imageViews.kf.setImage(with: URL(string: favori))
            cell.priceLabel.text = "$ \(price)"
            cell.titleLabel.text = title
        }
        
       
        tableView.rowHeight = 82
        return cell
    }
    
}
