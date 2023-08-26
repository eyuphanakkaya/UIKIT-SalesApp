//
//  SalesViewModel.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 22.08.2023.
//

import Foundation
import UIKit

protocol ProductProtocol {
    func add(indexPath: IndexPath)
}
class callApi {
    static let api = "https://dummyjson.com/"
}
class SalesViewModel {
    var myProtocol: ProductProtocol?
    var indexPath: IndexPath?
    var cartList = [MyCart]()
    
    func getAllProduct(completion: @escaping([Product])->Void) async throws {
        guard let url = URL(string: "\(callApi.api)products") else {
            print("HATAAA!!!")
            return
        }
        let data: (Data,URLResponse) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductResult.self, from: data.0)
        if let results = result.products {
            completion(results)
        }
        
    }
    func getAllCate(completion: @escaping([String])-> Void) async throws {
        guard let url = URL(string: "\(callApi.api)products/categories") else{
            print("Hata")
            return
        }
        let data = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([String].self, from: data.0)
        completion(result)
        
    }
    func fetchCate(find: String,completion: @escaping([Product])->Void) async throws {
        guard let url = URL(string: "\(callApi.api)products/category/\(find)") else{
            print("Hata")
            return
        }
      let data = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductResult.self, from: data.0)
        if let results = result.products {
            completion(results)
        }
    }


}
