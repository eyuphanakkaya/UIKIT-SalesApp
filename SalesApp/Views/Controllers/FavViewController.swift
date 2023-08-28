//
//  FavViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 28.08.2023.
//

import UIKit

class FavViewController: UIViewController {
    var viewModel: SalesViewModel?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func cartClicked(_ sender: Any) {
        
    }
    
}
