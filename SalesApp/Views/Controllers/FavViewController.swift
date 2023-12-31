//
//  FavViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 28.08.2023.
//

import UIKit
import Firebase

class FavViewController: UIViewController {
    var viewModel = SalesViewModel()
    var myList = [MyFav]()
    var ref: DatabaseReference?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        allFav()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.fetchProduct()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFav" {
            let index = sender as? Int
            let toDestination = segue.destination as! DetailViewController
            toDestination.product = viewModel.productList[index! - 1 ]
            
        }
    }
    func allFav() {
        ref?.child("MyFav").observe(.value, with: { snapshot in
            if let gelenVeri = snapshot.value as? [String: Any] {
                self.myList.removeAll()
                for gelenSatir in gelenVeri {
                    if let sozluk = gelenSatir.value as? NSDictionary {
                        let image = sozluk["image"] as? String ?? ""
                        let title = sozluk["title"] as? String ?? ""
                        let price = sozluk["price"] as? Int ?? 0
                        let myFavItem = MyFav(id:sozluk["id"] as? Int ?? 0 ,
                                              image: image,
                                              title: title,
                                              price: price)
                        self.myList.append(myFavItem)
                    }
                }
                self.tableView.reloadData()
            }
            
        })
    }


    
}
