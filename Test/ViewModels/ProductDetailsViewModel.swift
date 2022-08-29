//
//  ProductDetailsViewModel.swift
//  Test
//
//  Created by Eugeny Matylitski on 26.08.22.
//

import Foundation


class ProductDetailsViewModel{
    
    func loadProductDetails(completion : @escaping (ProductDetailsModel) -> ()) {
        guard let url  = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            do {
                let productData = try JSONDecoder().decode(ProductDetailsModel.self, from: data)
                DispatchQueue.main.async {
                    completion (productData)
                }
            } catch{
                print(error)
            }
        }.resume()
        
    }
    
}
