//
//  ProductDetailInteractor.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

final class ProductDetailInteractor: ProductDetailInteractorInputProtocol {
    // MARK: - Properties
    weak var presenter: ProductDetailInteractorOutputProtocol?
    let product: Product
    private let productService: ProductServiceProtocol
    
    // MARK: - Initialization
    init(
        product: Product,
        productService: ProductServiceProtocol = ProductService()
    ) {
        self.product = product
        self.productService = productService
    }
    
    // MARK: - ProductDetailInteractorInputProtocol
     func fetchProductDetails() {
         // If you need to fetch fresh data from the server
         productService.fetchProduct(id: Int(product.id) ?? 0) { [weak self] result in
             guard let self = self else { return }
             
             DispatchQueue.main.async {
                 switch result {
                 case .success(_):
                     // Convert DTO to domain model if needed
                     self.presenter?.productDetailsFetched()
                     
                 case .failure(let error):
                     self.presenter?.productDetailsFetchFailed(error: error)
                 }
             }
         }
         
         // Check cart status immediately
         checkCartStatus()
     }
    
    func toggleCartStatus() {
        if Cart.shared.isProductInCart(product) {
            Cart.shared.removeFromCart(product)
            presenter?.cartStatusUpdated(isInCart: false)
        } else {
            Cart.shared.addToCart(product)
            presenter?.cartStatusUpdated(isInCart: true)
        }
    }
    
    // MARK: - Private Methods
    private func checkCartStatus() {
        let isInCart = Cart.shared.isProductInCart(product)
        presenter?.cartStatusUpdated(isInCart: isInCart)
    }
}

