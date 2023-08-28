//
//  SalesModel.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 22.08.2023.
//

import Foundation
import UIKit

struct ProductResult: Codable {
    var products: [Product]?
}
struct Product: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}
struct MyCart {
    let id: Int?
    let image: String?
    let title: String
    let price: Int
}
struct MyFav {
    let id: Int?
    let image: String?
    let title: String
    let price: Int
}

