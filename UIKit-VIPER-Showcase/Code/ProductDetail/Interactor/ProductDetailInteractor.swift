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
//    private let cartService: CartServiceProtocol
    private let productService: ProductServiceProtocol
    
    // MARK: - Initialization
    init(
        product: Product,
//        cartService: CartServiceProtocol = CartService.shared,
        productService: ProductServiceProtocol = ProductService()
    ) {
        self.product = product
//        self.cartService = cartService
        self.productService = productService
    }
    
    // MARK: - ProductDetailInteractorInputProtocol
     func fetchProductDetails() {
         // If you need to fetch fresh data from the server
         productService.fetchProduct(id: Int(product.id) ?? 0) { [weak self] result in
             guard let self = self else { return }
             
             switch result {
             case .success(let productDTO):
                 // Convert DTO to domain model if needed
                 // let updatedProduct = productDTO.toDomain()
                 // self.presenter?.productDetailsFetched()
                 break
                 
             case .failure(let error):
                 self.presenter?.productDetailsFetchFailed(error: error)
             }
         }
         
         // Check cart status immediately
         checkCartStatus()
     }
    
    func toggleCartStatus() {
//        if cartService.isProductInCart(product.id) {
//            cartService.removeFromCart(productId: product.id)
//            presenter?.cartStatusUpdated(isInCart: false)
//        } else {
//            cartService.addToCart(product: product)
//            presenter?.cartStatusUpdated(isInCart: true)
//        }
    }
    
    // MARK: - Private Methods
    private func checkCartStatus() {
//        let isInCart = cartService.isProductInCart(product.id)
//        presenter?.cartStatusUpdated(isInCart: isInCart)
    }
}

