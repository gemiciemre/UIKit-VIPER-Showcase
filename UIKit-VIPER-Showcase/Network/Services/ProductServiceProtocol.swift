//
//  ProductServiceProtocol.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[ProductDTO], NetworkError>) -> Void)
    func fetchProduct(id: Int, completion: @escaping (Result<ProductDTO, NetworkError>) -> Void)
    func fetchProductsByCategory(_ category: String, completion: @escaping (Result<[ProductDTO], NetworkError>) -> Void)
}
