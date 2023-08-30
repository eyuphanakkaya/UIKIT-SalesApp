//
//  AllcateViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 30.08.2023.
//

import UIKit

class AllCateViewController: UIViewController {
    var viewModel: SalesViewModel?
    @IBOutlet weak var tableView: UITableView!
    var cateList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchCate()
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductVC" {
            let index = sender as? Int
            let toDestination = segue.destination as! CateViewController
            toDestination.cateFind = cateList[index!]
            toDestination.viewModel = viewModel
        }
    }
    func fetchCate() {
        Task {
            try await viewModel?.getAllCate { cate in
                self.cateList.append(contentsOf: cate)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
