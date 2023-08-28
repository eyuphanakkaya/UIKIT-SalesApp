//
//  CartViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 24.08.2023.
//

import UIKit
import CoreLocation

class CartViewController: UIViewController {
    var productList = [Product]()
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: SalesViewModel?
    var product: Product?
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        if let total = viewModel?.totalPrice{
            totalPriceLabel.text = "$\(total)"
        }
        

    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetailVC1" {
//            let index = sender as? Int
//            let toDestionation = segue.destination as! DetailViewController
//            toDestionation.product = productList[index!]
//            toDestionation.viewModel = viewModel
//           
//        }
//    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
        
    }
    @IBAction func paymentsClicked(_ sender: Any) {
        print("Ödeme yapıldı.")
    }
}
