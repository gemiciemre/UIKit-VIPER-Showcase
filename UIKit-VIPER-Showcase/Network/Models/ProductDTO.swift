//
//  ProductDTO.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

struct ProductDTO: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: RatingDTO
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, description, category, image, rating
    }
}

struct RatingDTO: Codable {
    let rate: Double
    let count: Int
}

extension ProductDTO {
    func toDomain() -> Product {
        return Product(
            id: "\(id)",
            name: title,
            price: price,
            description: description,
            category: category,
            imageURL: image,
            rating: rating.rate,
            reviewCount: rating.count
        )
    }
}
