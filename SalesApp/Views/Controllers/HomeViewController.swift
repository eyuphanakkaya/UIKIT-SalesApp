//
//  HomeViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 21.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
    }
    
}
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
        cell?.imageView.image = UIImage(named: "resim1")
        
        return cell!
        
    }
    
    
    
}

