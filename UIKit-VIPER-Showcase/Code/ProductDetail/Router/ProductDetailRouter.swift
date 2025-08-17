//
//  ProductDetailRouter.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation
import UIKit

class ProductDetailRouter: ProductDetailRouterProtocol {
    
    static func createProductDetailModule(with product: Product) -> UIViewController {
        let view = ProductDetailViewController()
        let presenter = ProductDetailPresenter(product: product)
        let interactor = ProductDetailInteractor(product: product)
        let router = ProductDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateBack(from view: (any ProductDetailViewProtocol)?) {
        if let viewController = view as? UIViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
}
