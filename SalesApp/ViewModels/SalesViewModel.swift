//
//  SalesViewModel.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 22.08.2023.
//

import Foundation
import UIKit

class callApi {
    static let api = "https://dummyjson.com/"
}
class SalesViewModel {
    
    
    func getAllProduct(completion: @escaping([Product])->Void) {
        guard let url = URL(string: "\(callApi.api)products") else {
            print("hataa")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else{
                print(error)
                return
            }
            do {
                let result =  try JSONDecoder().decode(ProductResult.self, from: data!)
                if let results = result.products {
                    completion(results)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    func getAllCate(completion: @escaping([String])->Void) {
        guard let url = URL(string: "\(callApi.api)products/categories") else{
            print("Hata")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            do {
                let result = try JSONDecoder().decode([String].self, from: data!)
                completion(result)
                print(result)
            } catch {
                print(error)
            }
        }.resume()
    }
    //https://dummyjson.com/products/category/smartphones
    func fetchCate(find: String,completion: @escaping([Product])->Void) {
        guard let url = URL(string: "\(callApi.api)products/category/\(find)") else{
            print("Hata")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            do {
                let result = try JSONDecoder().decode(ProductResult.self, from: data!)
                if let results = result.products {
                    completion(results)
                    print(results)
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }

}
