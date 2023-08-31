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
        guard let id = product?.id ,
              let image = product?.thumbnail,
              let price = product?.price,
              let title = product?.title else{
            return
        }
        let cart = MyCart(id: id, image: image, title: title, price: price,piece: 1)
        
        ref?.child("MyCart").queryOrdered(byChild: "id").queryEqual(toValue: cart.id).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                if let cartDict = snapshot.value as? [String: Any],
                   let cartId = cartDict.keys.first {
                    var updatedPiece = cart.piece
                    if let existingPiece = cartDict[cartId] as? [String: Any],
                       let existingPieceCount = existingPiece["piece"] as? Int {
                        updatedPiece += existingPieceCount
                    }
                    let updateDict: [String: Any] = ["piece": updatedPiece]
                    self.ref?.child("MyCart").child(cartId).updateChildValues(updateDict) { error, _ in
                        if let error = error {
                            print("Güncelleme hatası: \(error.localizedDescription)")
                        } else {
                            print("Ürün güncellendi")
                        }
                    }
                }
                print("ürün zaten var ")
            } else {
                let dict: [String:Any] = ["id": id,"image":image,"title":cart.title,"price":cart.price,"piece":cart.piece]
                let newRef = self.ref?.child("MyCart").childByAutoId()
                newRef?.setValue(dict)
                
                print("eklendi")
                
            }
        })
        
    }
    func checkData(image: String,title: String, price: Int) {
        
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
        if let id = product?.id ,
           let image = product?.thumbnail ,
           let title = product?.title ,
           let price = product?.price {
//            ref?.child("MyCart").queryOrdered(byChild: "id").queryEqual(toValue: id).observeSingleEvent(of: .value, with: { snapshot in
//                if snapshot.exists() {
//            })
        if favState {
                let fav = MyFav(id: id, image: image, title: title, price: price)
                    if let id = fav.id ,
                       let image = fav.image {
                        let dict: [String:Any] = ["id": id,"image":image,"title":fav.title,"price":fav.price]
                        let newRef = ref?.child("MyFav").childByAutoId()
                        newRef?.setValue(dict)
                        
                        print("eklendi")
                    }
            } else {
                ref?.child("MyFav").child("\(id)").removeValue(completionBlock: { error , _  in
                    if let error = error {
                        print("Veri silinirken hata oluştu: \(error)")
                    } else {
                        print("Veri başarıyla silindi.")
                    }
                })
                
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

