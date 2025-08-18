//
//  CartViewProtocol.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation
import UIKit

protocol CartViewProtocol: AnyObject {
    func showCartItems(_ items: [CartItem])
    func updateCartTotal(price: Double, itemCount: Int)
    func showError(_ message: String)
}

// MARK: - Presenter
protocol CartPresenterProtocol: AnyObject {
    var view: CartViewProtocol? { get set }
    var router: CartRouterProtocol? { get set }
    var interactor: CartInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func updateQuantity(for product: Product, quantity: Int)
    func removeItem(_ product: Product)
    func checkout()
    func getCartItemCount() -> Int
}

// MARK: - Interactor
protocol CartInteractorInputProtocol: AnyObject {
    var presenter: CartInteractorOutputProtocol? { get set }
    
    func getCartItems() -> [CartItem]
    func updateCartItem(_ product: Product, quantity: Int)
    func removeFromCart(_ product: Product)
    func getCartSummary() -> (totalPrice: Double, itemCount: Int)
}

protocol CartInteractorOutputProtocol: AnyObject {
    func cartUpdated(_ items: [CartItem])
    func cartUpdateFailed(_ error: String)
}

// MARK: - Router
protocol CartRouterProtocol: AnyObject {
    static func createCartModule() -> UIViewController
    func presentCheckout(from view: CartViewProtocol?)
}
