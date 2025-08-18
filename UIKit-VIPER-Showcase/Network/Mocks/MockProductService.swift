//
//  MockProductService.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation

final class MockProductService: ProductServiceProtocol {
    
    func fetchProducts(completion: @escaping (Result<[ProductDTO], NetworkError>) -> Void) {
        // Simulate network delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let mockProducts = self.createMockProducts()
            completion(.success(mockProducts))
        }
    }
    
    func fetchProduct(id: Int, completion: @escaping (Result<ProductDTO, NetworkError>) -> Void) {
        // Simulate network delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let mockProducts = self.createMockProducts()
            if let product = mockProducts.first(where: { $0.id == id }) {
                completion(.success(product))
            } else {
                completion(.failure(.noData))
            }
        }
    }
    
    func fetchProductsByCategory(_ category: String, completion: @escaping (Result<[ProductDTO], NetworkError>) -> Void) {
        // Simulate network delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let mockProducts = self.createMockProducts()
            let filteredProducts = mockProducts.filter { $0.category.lowercased() == category.lowercased() }
            completion(.success(filteredProducts))
        }
    }
    
    private func createMockProducts() -> [ProductDTO] {
        return [
            ProductDTO(
                id: 1,
                title: "iPhone 15 Pro",
                price: 45999.99,
                description: "Apple'ın en gelişmiş akıllı telefonu. Titanium tasarım ve A17 Pro çip ile güçlendirilmiş.",
                category: "electronics",
                image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-bluetitanium-select?wid=470&hei=556&fmt=png-alpha&.v=1693086016319",
                rating: RatingDTO(rate: 4.8, count: 1250)
            ),
            ProductDTO(
                id: 2,
                title: "MacBook Air M3",
                price: 34999.99,
                description: "M3 çip ile güçlendirilmiş MacBook Air. Ultra hafif ve güçlü performans.",
                category: "electronics",
                image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/macbook-air-midnight-select-20220606?wid=904&hei=840&fmt=jpeg&qlt=90&.v=1653084303665",
                rating: RatingDTO(rate: 4.9, count: 890)
            ),
            ProductDTO(
                id: 3,
                title: "AirPods Pro 2",
                price: 7999.99,
                description: "Aktif gürültü engelleme ve şeffaflık modu ile mükemmel ses deneyimi.",
                category: "electronics",
                image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1660803972361",
                rating: RatingDTO(rate: 4.7, count: 2100)
            ),
            ProductDTO(
                id: 4,
                title: "Apple Watch Series 9",
                price: 12999.99,
                description: "Gelişmiş sağlık sensörleri ve S9 çip ile daha akıllı Apple Watch.",
                category: "electronics",
                image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/watch-s9-gps-select-aluminum-pink-202309?wid=470&hei=556&fmt=png-alpha&.v=1693086021308",
                rating: RatingDTO(rate: 4.6, count: 750)
            ),
            ProductDTO(
                id: 5,
                title: "iPad Pro 12.9\"",
                price: 39999.99,
                description: "M2 çip ile güçlendirilmiş iPad Pro. Profesyonel yaratıcılık için tasarlandı.",
                category: "electronics",
                image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-pro-12-select-wifi-spacegray-202210?wid=470&hei=556&fmt=png-alpha&.v=1664411207213",
                rating: RatingDTO(rate: 4.8, count: 650)
            ),
            ProductDTO(
                id: 6,
                title: "Nike Air Max 270",
                price: 3499.99,
                description: "Maksimum konfor ve stil için tasarlanmış spor ayakkabı.",
                category: "clothing",
                image: "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/awjogtdnqxniqqk0wpgf/air-max-270-mens-shoes-KkLcGR.png",
                rating: RatingDTO(rate: 4.5, count: 1890)
            ),
            ProductDTO(
                id: 7,
                title: "Adidas Ultraboost 22",
                price: 4299.99,
                description: "Enerji geri dönüşümü teknolojisi ile koşu deneyimini yeniden tanımlar.",
                category: "clothing",
                image: "https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/fbaf991a78bc4896a3e9ad7800abcec6_9366/Ultraboost_22_Shoes_Black_GZ0127_01_standard.jpg",
                rating: RatingDTO(rate: 4.7, count: 1200)
            ),
            ProductDTO(
                id: 8,
                title: "Samsung Galaxy S24 Ultra",
                price: 42999.99,
                description: "S Pen ile güçlendirilmiş Galaxy S24 Ultra. AI destekli kamera sistemi.",
                category: "electronics",
                image: "https://images.samsung.com/is/image/samsung/p6pim/tr/2401/gallery/tr-galaxy-s24-ultra-s928-sm-s928bztqtur-thumb-539573257",
                rating: RatingDTO(rate: 4.6, count: 980)
            )
        ]
    }
}
