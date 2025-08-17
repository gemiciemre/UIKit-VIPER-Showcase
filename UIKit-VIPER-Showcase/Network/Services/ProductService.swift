//
//  ProductService.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

final class ProductService: ProductServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductDTO], NetworkError>) -> Void) {
        let endpoint = ProductEndpoint.getProducts
        networkManager.request(endpoint, completion: completion)
    }
    
    func fetchProduct(id: Int, completion: @escaping (Result<ProductDTO, NetworkError>) -> Void) {
        let endpoint = ProductEndpoint.getProduct(id: id)
        networkManager.request(endpoint, completion: completion)
    }
    
    func fetchProductsByCategory(_ category: String, completion: @escaping (Result<[ProductDTO], NetworkError>) -> Void) {
        let endpoint = ProductEndpoint.getProductsByCategory(category: category)
        networkManager.request(endpoint, completion: completion)
    }
}


