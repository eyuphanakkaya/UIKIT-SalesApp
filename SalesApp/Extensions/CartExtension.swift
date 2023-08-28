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
        if let viewModels = viewModel?.cartList {
            return  viewModels.count
        } else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cart =  viewModel?.cartList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableVCell
        if let image = cart?.image, let title = cart?.title, let price = cart?.price {
            cell.imageViews.kf.setImage(with: URL(string: image))
            cell.productNameLabel.text = title
            cell.viewModel = viewModel
            if let total = viewModel?.totalProduct, let price = viewModel?.price  {
                cell.productPriceLabel.text = "$\(price)"
                cell.pieceProductLabel.text = "\(total)"
            }
          
            
            tableView.rowHeight = 82
        }

        return cell
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
