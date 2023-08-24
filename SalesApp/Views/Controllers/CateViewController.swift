//
//  CateViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit

class CateViewController: UIViewController {

    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var viewModel = SalesViewModel()
    var cateFind: String?
    var productsList = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        productDesign()
        viewModel.fetchCate(find: cateFind ?? "") {  products in
                self.productsList.append(contentsOf: products)
            print(products)
            DispatchQueue.main.async {
                self.productTitleLabel.text = self.cateFind!.capitalized
                self.categoryCollectionView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let toDestionation = segue.destination as! DetailViewController
        toDestionation.product = productsList[index!]
    }

    func productDesign() {
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.itemSize = CGSize(width: 170, height: 217)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        categoryCollectionView.collectionViewLayout = design
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func cartClicked(_ sender: Any) {
        
    }
}
