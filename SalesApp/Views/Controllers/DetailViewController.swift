//
//  DetailViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var product: Product?
    var pageControl: UIPageControl!
    var imageViews: [UIImageView] = []
    var currentIndex: Int = 0
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false

        buyNowButton.layer.cornerRadius = 10
        addToCartButton.layer.cornerRadius = 10
        
        if let products = product {
            if let price = products.price ,
               let title = products.title ,
               let description = products.description,
               let brand = products.brand,
               let rating = products.rating
            {
                priceLabel.text = "$\(price)"
                productNameLabel.text = title
                brandLabel.text = brand
                ratingLabel.text = "\(rating)"
                descriptionTextView.text = description
                
            }
            
        }

        if let image = product?.images {
                   scrollView.contentSize = CGSize(width: CGFloat(image.count) * view.bounds.width, height: 200)
            for (index, imageURL) in image.enumerated() {
                let imageView = UIImageView()
                imageView.frame = CGRect(x: CGFloat(index) * view.bounds.width, y: 0, width: 390, height: 200)
                imageView.contentMode = .scaleAspectFit
                imageView.kf.setImage(with: URL(string: imageURL))
                
                imageViews.append(imageView)
                scrollView.addSubview(imageView)
            }
            
            pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
            pageControl.numberOfPages = image.count
            pageControl.currentPage = 0
            pageControl.tintColor = UIColor.red
            pageControl.pageIndicatorTintColor = UIColor.lightGray
            pageControl.currentPageIndicatorTintColor = UIColor.black
            view.addSubview(pageControl)
            view.addSubview(scrollView)
        }

    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    @IBAction func buyNowClicked(_ sender: Any) {
    }
    
    @IBAction func favClicked(_ sender: Any) {
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

