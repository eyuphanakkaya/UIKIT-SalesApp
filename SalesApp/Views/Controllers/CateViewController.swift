//
//  CateViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit
import Firebase

class CateViewController: UIViewController {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    var viewModel: SalesViewModel?
    var ref: DatabaseReference?
    var cateFind: String?
    var productsList = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        productDesign()
        
        
        ref = Database.database().reference()
        
        cate()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let index = sender as? Int
            let toDestionation = segue.destination as! DetailViewController
            toDestionation.product = productsList[index!]
        } else if segue.identifier == "toCart" {
            let toDestionation = segue.destination as! CartViewController
            toDestionation.viewModel = viewModel
        }
        
    }
    
    func productDesign() {
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.itemSize = CGSize(width: 170, height: 217)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        categoryCollectionView.collectionViewLayout = design
    }
    func cate(){
        Task {
            try await viewModel?.fetchCate(find: cateFind ?? "") {  products in
                self.productsList.append(contentsOf: products)
                DispatchQueue.main.async {
                    self.productTitleLabel.text = self.cateFind!.capitalized
                    self.categoryCollectionView.reloadData()
                }
            }
        }
        
    }

    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func cartClicked(_ sender: Any) {
        performSegue(withIdentifier: "toCart", sender: nil)
    }
}
