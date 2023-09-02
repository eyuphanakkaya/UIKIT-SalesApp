//
//  SearchViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 24.08.2023.
//

import UIKit

class SearchViewController: UIViewController {
    var productList = [Product]()
    @IBOutlet weak var searchCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        productDesign()
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchDetail" {
            let index = sender as! Int
            let toDestination = segue.destination as? DetailViewController
            toDestination?.product = productList[index - 1]
        }
    }
    
    func productDesign() {
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.itemSize = CGSize(width: 170, height: 217)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        searchCollectionView.collectionViewLayout = design
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}
