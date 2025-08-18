//
//  CartRouter.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation
import UIKit

class CartRouter: CartRouterProtocol {
    
    static func createCartModule() -> UIViewController {
        let view = CartViewController()
        let presenter = CartPresenter()
        let interactor = CartInteractor()
        let router = CartRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func presentCheckout(from view: CartViewProtocol?) {
        if let sourceView = view as? UIViewController {
            let alert = UIAlertController(
                title: "Ödeme Ekranı",
                message: "Ödeme ekranına yönlendiriliyorsunuz...",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            sourceView.present(alert, animated: true)
        }
    }
}
