//
//  NetworkService.swift
//  Test
//
//  Created by Eugeny Matylitski on 23.08.22.
//

import Foundation
import UIKit

final class HomeViewModel{
    enum Content : String {
        case mainScreenInfo = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        case phoneInfo = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
        case cartInfo = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    }
    func loadHotSales(content : Content, completion : @escaping (HomeVCModel) -> ()){
        guard let url = URL(string: content.rawValue) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            
            do{
                let responseData = try JSONDecoder().decode(HomeVCModel.self, from: data)
                DispatchQueue.main.async {
                    completion(responseData)
                }
            }catch{
                print(error)
            }
            
            
        }.resume()
    }
    
    func loadPicture(urlStrings: [String] , completion: @escaping ([Data]) -> Void){
        var allPictures : [Data] = []
        urlStrings.forEach { urlString in
            guard let url = URL(string: urlString) else {return}
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let data = data else {return}
                allPictures.append(data)
                if allPictures.count == urlStrings.count{
                DispatchQueue.main.async {
                    completion(allPictures)
                }
                }
            }.resume()
        }
        
    }
    
    
    func loadBestSellers(urlString: String , completion: @escaping (Data) -> Void){
            guard let url = URL(string: urlString) else {return}
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let data = data else {return}
                DispatchQueue.main.async {
                    completion(data)
                }
            }.resume()
        }
        
}
