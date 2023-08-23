//
//  CateViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit

class CateViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var viewModel: SalesViewModel?
    var productsList = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        productDesign()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchCate(find: "smartphones", completion: { cate in
                self.productsList.append(contentsOf: cate)
            DispatchQueue.main.async {
                self.categoryCollectionView.reloadData()
            }
        })
    }
    func productDesign() {
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.itemSize = CGSize(width: 170, height: 217)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        categoryCollectionView.collectionViewLayout = design
    }

}
