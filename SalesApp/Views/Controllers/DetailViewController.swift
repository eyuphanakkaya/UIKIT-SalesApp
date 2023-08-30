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
    var favState = false
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPayVC" {
            let toDestionation = segue.destination as! CartViewController
            toDestionation.viewModel = viewModel
        }
    }
    
    func addBasket() {
        if let viewModels = viewModel ,
           let fetchProduct = product ,
           let id = fetchProduct.id,
           let image = fetchProduct.thumbnail,
           let title = fetchProduct.title ,
           let price = fetchProduct.price {
            let cart = MyCart(id: id, image: image, title: title, price: price,piece: 1)
            if !viewModels.cartList.contains(where: {$0.id == cart.id}) {
                viewModels.cartList.append(cart)
        //        viewModels.price = viewModels.price + Double(price)
                viewModels.totalPrice = viewModels.totalPrice + Double(price)
            } else {
                
                viewModels.totalProduct = viewModels.totalProduct + 1
        //        viewModels.price = viewModels.price + Double(price)
                viewModels.totalPrice = viewModels.totalPrice + Double(price)

            }
            
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        addBasket()
    }
    
    @IBAction func buyNowClicked(_ sender: Any) {
        addBasket()
        performSegue(withIdentifier: "toPayVC", sender: nil)
    }
    
    @IBAction func favClicked(_ sender: Any) {
        favState.toggle()
        if favState {

            if let id = product?.id ,
               let image = product?.thumbnail ,
               let title = product?.title ,
               let price = product?.price ,
               let view = viewModel {
                let fav = MyFav(id: id, image: image, title: title, price: price)
                if !view.favList.contains(where: {$0.id == product?.id }) {
                    view.favList.append(fav)
                    let dict: [String:Any] = ["id": fav.id,"image":fav.image,"title":fav.title,"price":fav.price]
                    let newRef = ref?.child("MyFav").childByAutoId()
                    newRef?.setValue(dict)

                    print("eklendi")
                } else {
                    print("Veri zaten favoride")
                }
            }
        }

    }
    
    @IBAction func cartClicked(_ sender: Any) {
        performSegue(withIdentifier: "toPayVC", sender: nil)
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

