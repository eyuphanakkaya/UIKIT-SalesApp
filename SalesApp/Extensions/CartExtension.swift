//
//  CartExtension.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 25.08.2023.
//

import Foundation
import UIKit
import Kingfisher
import CoreLocation

extension CartViewController: UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCartList.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cart =  myCartList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableVCell
        cell.imageViews.kf.setImage(with: URL(string: cart.image ?? ""))
        cell.productNameLabel.text = cart.title
        cell.productPriceLabel.text = "$\(cart.price)"
        cell.pieceProductLabel.text = "\(cart.piece)"
        cell.product = cart
        cell.ref = ref
        
        tableView.rowHeight = 82
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cart = myCartList[indexPath.row]
        
        performSegue(withIdentifier: "toDetailVC1", sender: cart.id)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                if let city = placemark.locality, let district = placemark.subLocality {
                    self.locationLabel.text = "\(city), \(district)"
                } else {
                    print("City and district information not available.")
                }
            } else {
                print("Placemark not found.")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
}
