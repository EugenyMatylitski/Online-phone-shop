//
//  ProductDetailsModel.swift
//  Test
//
//  Created by Eugeny Matylitski on 26.08.22.
//

import Foundation

struct ProductDetailsModel: Decodable {
    let CPU : String
    let camera: String
    let capacity : [String]
    let color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd : String
    let ssd : String
    let title: String
}
