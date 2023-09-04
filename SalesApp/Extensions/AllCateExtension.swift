//
//  AllcateExtension.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 30.08.2023.
//

import Foundation
import UIKit
import Kingfisher

extension AllCateViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateList.prefix(10).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cate = cateList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "allcateCell", for: indexPath) as! AllCateTableVCell
        cell.cateNameLabel.text = cate.uppercased()
        switch cate {
        case "smartphones":
            cell.imageViews.image = UIImage(named: "phone")
        case "laptops":
            cell.imageViews.image = UIImage(named: "laptop")
        case "fragrances":
            cell.imageViews.image = UIImage(named: "fragrances")
        case "skincare":
            cell.imageViews.image = UIImage(named: "skincare")
        case "groceries":
            cell.imageViews.image = UIImage(named: "groceries")
        case "home-decoration":
            cell.imageViews.image = UIImage(named: "decoration")
        case "furniture":
            cell.imageViews.image = UIImage(named: "furniture")
        case "tops":
            cell.imageViews.image = UIImage(named: "top")
        case "womens-dresses":
            cell.imageViews.image = UIImage(named: "dresses")
        case "womens-shoes":
            cell.imageViews.image = UIImage(named: "shoe")
        default:
            print("")
        }
        tableView.rowHeight = 82
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toProductVC", sender: indexPath.row)
    }
}
