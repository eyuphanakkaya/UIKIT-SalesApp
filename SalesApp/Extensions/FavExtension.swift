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
        
        return myList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fav = myList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavTableVCell
        if let image = fav.image
        {
            cell.imageViews.kf.setImage(with: URL(string: image))

        }
        cell.titleLabel.text = fav.title
        cell.priceLabel.text = "$ \(fav.price)"
        
        
       
        tableView.rowHeight = 82
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fav = myList[indexPath.row]
        performSegue(withIdentifier: "toDetailFav", sender: fav.id)
    }
    
}
