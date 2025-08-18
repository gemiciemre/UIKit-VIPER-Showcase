//
//  CartInteractor.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation
import UIKit

class CartInteractor: CartInteractorInputProtocol {
    weak var presenter: CartInteractorOutputProtocol?
    private let cart = Cart.shared
    
    init() {
        setupCartObserver()
    }
    
    deinit {
        Cart.shared.removeCartUpdateObserver(self)
    }
    
    func getCartItems() -> [CartItem] {
        return cart.getCartItems()
    }
    
    func updateCartItem(_ product: Product, quantity: Int) {
        cart.updateQuantity(for: product, quantity: quantity)
    }
    
    func removeFromCart(_ product: Product) {
        cart.removeFromCart(product)
    }
    
    func getCartSummary() -> (totalPrice: Double, itemCount: Int) {
        return (cart.getTotalPrice(), cart.getTotalItemCount())
    }
    
    private func setupCartObserver() {
        Cart.shared.addCartUpdateObserver(self, selector: #selector(handleCartUpdate))
    }
    
    @objc private func handleCartUpdate() {
        let items = cart.getCartItems()
        presenter?.cartUpdated(items)
    }
}

// MARK: - Cart Update Observer
extension CartInteractor {
    func startObservingCart() {
        // Already set up in init
    }
}
