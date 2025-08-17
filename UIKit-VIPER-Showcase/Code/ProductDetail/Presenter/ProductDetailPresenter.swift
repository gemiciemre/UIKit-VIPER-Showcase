//
//  ProductDetailPresenter.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    // MARK: - Properties
    weak var view: ProductDetailViewProtocol?
    var interactor: ProductDetailInteractorInputProtocol?
    var router: ProductDetailRouterProtocol?
    
    private let product: Product
    
    // MARK: - Initialization
    init(product: Product) {
        self.product = product
    }
    
    func viewDidLoad() {
        view?.showProduct(product)
        interactor?.fetchProductDetails()
    }
    
    func addToCartButtonTapped() {
        interactor?.toggleCartStatus()
    }
    
    func refreshData() {
        interactor?.fetchProductDetails()
    }
}

// MARK: - ProductDetailInteractorOutputProtocol
extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func productDetailsFetched() {
        // Update view with fresh data if needed
        // For example, if product details were updated
    }
    
    func productDetailsFetchFailed(error: Error) {
        view?.showError(error.localizedDescription)
    }
    
    func cartStatusUpdated(isInCart: Bool) {
        view?.updateCartButton(isInCart: isInCart)
    }
}
