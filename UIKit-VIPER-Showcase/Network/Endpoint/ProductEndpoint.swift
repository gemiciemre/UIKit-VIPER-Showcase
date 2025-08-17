//
//  ProductEndpoint.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

// MARK: - Product Endpoint

enum ProductEndpoint: Endpoint {
    case getProducts
    case getProduct(id: Int)
    case getProductsByCategory(category: String)
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getProduct(let id):
            return "/products/\(id)"
        case .getProductsByCategory(let category):
            let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? category
            return "/products/category/\(encodedCategory)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}
