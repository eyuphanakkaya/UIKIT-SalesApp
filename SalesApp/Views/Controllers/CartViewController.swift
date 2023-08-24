//
//  CartViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 24.08.2023.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
        
    }
    @IBAction func paymentsClicked(_ sender: Any) {
        print("Ödeme yapıldı.")
    }
}
