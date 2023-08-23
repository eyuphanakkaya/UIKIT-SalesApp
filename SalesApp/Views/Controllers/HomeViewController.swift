//
//  HomeViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 21.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    var productList = [Product]()
    var cateList = [String]()
    var viewModel = SalesViewModel()
    
    @IBOutlet weak var cateCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        cateCollectionView.delegate = self
        cateCollectionView.dataSource = self
        
        productDesign()
        cateDesign()
        viewModel.getAllCate { cate in
            self.cateList.append(contentsOf: cate)
            DispatchQueue.main.async {
                self.cateCollectionView.reloadData()
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let toDestination = segue.destination as!  DetailViewController
        toDestination.product = productList[index!]
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getAllProduct {  products in
                self.productList.append(contentsOf: products)
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }

    }
    func productDesign() {
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.itemSize = CGSize(width: 170, height: 217)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        productCollectionView.collectionViewLayout = design
    }
    func cateDesign() {
        let design = UICollectionViewFlowLayout()
        design.scrollDirection = .horizontal
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.itemSize = CGSize(width: 70, height: 61)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        cateCollectionView.collectionViewLayout = design
    }
    
    @IBAction func myCartClicked(_ sender: Any) {
        
    }
    @IBAction func allCateClicked(_ sender: Any) {
        
    }
}



