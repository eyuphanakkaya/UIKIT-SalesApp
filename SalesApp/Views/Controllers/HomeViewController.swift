//
//  HomeViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 21.08.2023.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    var productList = [Product]()
    var cateList = [String]()
    var cateViewController = CateViewController()
    var viewModel = SalesViewModel()
    var myCartList = [MyCart]()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var myLocation: UILabel!
    @IBOutlet weak var myPopUpButton: UIButton!
    @IBOutlet weak var cateCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        cateCollectionView.delegate = self
        cateCollectionView.dataSource = self
        
       
        
        productDesign()
        cateDesign()
        
        fetchCate()
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let index = sender as? Int
            let toDestination = segue.destination as!  DetailViewController
            toDestination.product = productList[index!]
            toDestination.viewModel = viewModel
        } else if segue.identifier == "toCateVC" {
            let index = sender as? Int
            let toDestination = segue.destination as! CateViewController
            toDestination.cateFind = cateList[index!]
            toDestination.viewModel = viewModel
        } else if segue.identifier == "toCartVc" {
            let toDestination = segue.destination as! CartViewController
            toDestination.viewModel = viewModel
        } else if segue.identifier == "toFavVC" {
            let toDestionation = segue.destination as! FavViewController
            toDestionation.viewModel = viewModel
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool)  {
        Task {
            try await viewModel.getAllProduct {  products in
                self.productList.append(contentsOf: products)
                
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
            }
        }
        setPopUpButton()
    }
    
    func fetchCate() {
        Task {
            try await viewModel.getAllCate { cate in
                self.cateList.append(contentsOf: cate)
                DispatchQueue.main.async {
                    self.cateCollectionView.reloadData()
                }
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
    func setPopUpButton() {
        
        myPopUpButton.menu = UIMenu(children: [
            UIAction(title: "A to Z", handler: { action in
                print("Hepsini getir")
                Task {
                    try await self.viewModel.getAllProduct {  products in
                        self.productList.append(contentsOf: products)
                        self.productList.sort{$0.title ?? "" < $1.title ?? ""}
                        DispatchQueue.main.async {
                            self.productCollectionView.reloadData()
                        }
                    }
                }
                
            }),
            UIAction(title: "Decreasing by price", handler: { action in
                print("fiyata göre azalan")
                Task {
                    try await self.viewModel.getAllProduct {  products in
                        self.productList.append(contentsOf: products)
                        self.productList.sort{$0.price ?? 0 > $1.price ?? 0}
                        DispatchQueue.main.async {
                            self.productCollectionView.reloadData()
                        }
                    }
                }
                
                
            }),
            UIAction(title: "Increasing by price", handler: { action in
                print("fiyata göre artan")
                Task {
                    try await self.viewModel.getAllProduct {  products in
                        self.productList.append(contentsOf: products)
                        self.productList.sort{$0.price ?? 0 < $1.price ?? 0}
                        DispatchQueue.main.async {
                            self.productCollectionView.reloadData()
                        }
                    }
                    
                }
            })
        ])
    }
    
    @IBAction func cartClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFavVC", sender: nil)
    }
    
    
}



