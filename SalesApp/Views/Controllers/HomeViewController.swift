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
    var cateImageList = [CateImage]()
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
//    func cateImage(){
//        let k1 = CateImage(id: 1, image: "resim1")
//        let k2 = CateImage(id: 2, image: "resim1")
//        let k3 = CateImage(id: 3, image: "resim1")
//        let k4 = CateImage(id: 4, image: "resim1")
//        let k5 = CateImage(id: 5, image: "")
//        let k6 = CateImage(id: 6, image: "")
//        let k7 = CateImage(id: 7, image: "")
//        let k8 = CateImage(id: 8, image: "")
//        let k9 = CateImage(id: 9, image: "")
//        let k10 = CateImage(id: 10, image: "")
//        let k11 = CateImage(id: 11, image: "")
//        let k12 = CateImage(id: 12, image: "")
//        let k13 = CateImage(id: 13, image: "")
//        let k14 = CateImage(id: 14, image: "")
//        let k15 = CateImage(id: 15, image: "")
//        let k16 = CateImage(id: 16, image: "")
//        let k17 = CateImage(id: 17, image: "")
//        let k18 = CateImage(id: 18, image: "")
//        let k19 = CateImage(id: 19, image: "")
//        let k20 = CateImage(id: 20, image: "")
//        cateImageList.append(k1)
//        cateImageList.append(k2)
//        cateImageList.append(k3)
//        cateImageList.append(k4)
//        cateImageList.append(k5)
//        cateImageList.append(k6)
//        cateImageList.append(k7)
//        cateImageList.append(k8)
//        cateImageList.append(k9)
//        cateImageList.append(k10)
//        cateImageList.append(k11)
//        cateImageList.append(k12)
//        cateImageList.append(k13)
//        cateImageList.append(k14)
//        cateImageList.append(k15)
//        cateImageList.append(k16)
//        cateImageList.append(k17)
//        cateImageList.append(k18)
//        cateImageList.append(k19)
//        cateImageList.append(k20)
//    }
    
}



