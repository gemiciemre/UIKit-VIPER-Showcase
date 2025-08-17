//
//  DependencyContainer.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation
import Swinject
import UIKit

final class DependencyContainer {
    static let shared = DependencyContainer()
    let container = Container()
    
    private init() {
        registerServices()
    }
    
    private func registerServices() {
        // Network
        container.register(NetworkManagerProtocol.self) { _ in
            return NetworkManager.shared
        }.inObjectScope(.container)
        
        // Services
        container.register(ProductServiceProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkManagerProtocol.self)!
            return ProductService(networkManager: networkManager)
        }.inObjectScope(.container)
        
        // Interactors
        container.register(ProductListInteractorInputProtocol.self) { resolver in
            let service = resolver.resolve(ProductServiceProtocol.self)!
            return ProductListInteractor(productService: service)
        }
        
        // Presenters
        container.register(ProductListPresenterProtocol.self) { (_, view: ProductListViewProtocol) in
            let presenter = ProductListPresenter()
            let interactor = self.container.resolve(ProductListInteractorInputProtocol.self)!
            let router = self.container.resolve(ProductListRouterProtocol.self)!
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            
            (interactor as? ProductListInteractor)?.presenter = presenter as? ProductListInteractorOutputProtocol
            
            return presenter
        }
        
        // Routers
        container.register(ProductListRouterProtocol.self) { _ in
            return ProductListRouter()
        }
    }
    
    func resolveProductListViewController() -> UIViewController {
        let viewController = ProductListViewController()
        viewController.presenter = container.resolve(
            ProductListPresenterProtocol.self,
            argument: viewController as ProductListViewProtocol
        )!
        return viewController
    }
}
