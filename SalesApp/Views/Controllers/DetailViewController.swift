//
//  DetailViewController.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import UIKit
import Kingfisher
import Firebase

class DetailViewController: UIViewController {
    var ref: DatabaseReference?
    let collectionName = "MyFav"
    var favState: Bool?
    var product: Product?
    var pageControl: UIPageControl!
    var imageViews: [UIImageView] = []
    var currentIndex: Int = 0
    var viewModel: SalesViewModel?
    @IBOutlet weak var favButton: UIButton!
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
        
        ref = Database.database().reference()
        
        favState = false
        
        
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
    override func viewWillAppear(_ animated: Bool) {
        ref?.child("MyFav").queryOrdered(byChild: "title").queryEqual(toValue: product?.title).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                self.favButton.imageView?.image = UIImage(systemName: "heart.fill")
            } else {
                self.favButton.imageView?.image = UIImage(systemName: "heart")
                
            }
            
        })
    }

    @IBAction func addToCartClicked(_ sender: Any) {
        if let products = product,
           let referance = ref {
            viewModel?.addBasket(product: products, ref: referance)
            
        }
    }
    
    @IBAction func buyNowClicked(_ sender: Any) {
        if let products = product,
           let referance = ref {
            viewModel?.addBasket(product: products, ref: referance)
            
        }
        performSegue(withIdentifier: "toPayVC", sender: nil)
    }
    
    @IBAction func favClicked(_ sender: Any) {
        favState?.toggle()
        if let id = product?.id ,
           let image = product?.thumbnail ,
           let title = product?.title ,
           let price = product?.price {
            ref?.child("MyFav").queryOrdered(byChild: "title").queryEqual(toValue: title).observeSingleEvent(of: .value, with: { snapshot in
                if snapshot.exists() {
                    self.favButton.setImage(UIImage(systemName:"heart"), for: .normal)
                    self.ref?.child("MyFav").child("\(id)").removeValue(completionBlock: { error , _  in
                        if let error = error {
                            print("Veri silinirken hata oluştu: \(error)")
                        } else {
                            if let favDict = snapshot.value as? [String: Any],
                               let favId = favDict.keys.first {
                                self.ref?.child("MyFav").child(favId).removeValue() { error, _ in
                                    if let error = error {
                                        print("Güncelleme hatası: \(error.localizedDescription)")
                                        
                                    } else {
                                        print("Ürün silindi")
                                    }
                                }
                            }
                            print("Veri başarıyla silindi.")
                        }
                    })
                    print("veri zaten var")
                } else {
                    self.favButton.imageView?.image = UIImage(systemName: "heart.fill")
                    let fav = MyFav(id: id, image: image, title: title, price: price)
                    if let id = fav.id ,
                       let image = fav.image {
                        let dict: [String:Any] = ["id": id,"image":image,"title":fav.title,"price":fav.price]
                        let newRef = self.ref?.child("MyFav").childByAutoId()
                        newRef?.setValue(dict)
                        
                        print("eklendi")
                    }
                    
                }
            })
        }
        
    }
    

    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

