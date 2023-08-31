//
//  CartViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 24.08.2023.
//

import UIKit
import CoreLocation
import Firebase


class CartViewController: UIViewController {
    var productList = [Product]()
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var toplam = 0
    var ref: DatabaseReference?
    var viewModel: SalesViewModel?
    var product: Product?
    var myCartList = [MyCart]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        ref = Database.database().reference()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        for x in self.myCartList {
            self.toplam = self.toplam + x.price
        }
       
      
        DispatchQueue.main.async {
            self.allCart()

        }
       
    }
    func allCart() {
        ref?.child("MyCart").observe(.value, with: { snapshot in
            if let gelenVeri = snapshot.value as? [String: Any] {
                self.myCartList.removeAll()
                for gelenSatir in gelenVeri {
                    if let sozluk = gelenSatir.value as? NSDictionary {
                        let image = sozluk["image"] as? String ?? ""
                        let title = sozluk["title"] as? String ?? ""
                        let price = sozluk["price"] as? Int ?? 0
                        let piece = sozluk["piece"] as? Int ?? 0
                        let myCartItem = MyCart(id:sozluk["id"] as? Int ?? 0 ,
                                                image: image,
                                                title: title,
                                                price: price,
                                                piece: piece )
                        
                        self.myCartList.append(myCartItem)

                       
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }
            }
            
        })
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
        
    }
    @IBAction func paymentsClicked(_ sender: Any) {
        print("Ödeme yapıldı.")
    }
}
