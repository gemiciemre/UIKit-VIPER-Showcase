//
//  CartPresenter.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation

class CartPresenter: CartPresenterProtocol {
    weak var view: CartViewProtocol?
    var router: CartRouterProtocol?
    var interactor: CartInteractorInputProtocol? {
        didSet {
            (interactor as? CartInteractor)?.startObservingCart()
        }
    }
    
    private var cartItems: [CartItem] = []
    
    func viewDidLoad() {
        loadCartItems()
    }
    
    private func loadCartItems() {
        cartItems = interactor?.getCartItems() ?? []
        view?.showCartItems(cartItems)
        updateCartSummary()
    }
    
    func updateQuantity(for product: Product, quantity: Int) {
        interactor?.updateCartItem(product, quantity: quantity)
    }
    
    func removeItem(_ product: Product) {
        interactor?.removeFromCart(product)
    }
    
    func checkout() {
        guard !cartItems.isEmpty else {
            view?.showError("Sepetiniz boş")
            return
        }
        router?.presentCheckout(from: view)
    }
    
    func getCartItemCount() -> Int {
        return cartItems.count
    }
    
    private func updateCartSummary() {
        let summary = interactor?.getCartSummary() ?? (0.0, 0)
//        view?.updateCartTotal(price: summary.totalPrice, itemCount: summary.itemCount)
    }
}

// MARK: - CartInteractorOutputProtocol
extension CartPresenter: CartInteractorOutputProtocol {
    func cartUpdated(_ items: [CartItem]) {
        cartItems = items
        view?.showCartItems(items)
        updateCartSummary()
    }
    
    func cartUpdateFailed(_ error: String) {
        view?.showError(error)
    }
}
