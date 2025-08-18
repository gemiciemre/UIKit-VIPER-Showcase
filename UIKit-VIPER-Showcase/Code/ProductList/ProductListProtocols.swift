import Foundation
import UIKit

// MARK: - View
protocol ProductListViewProtocol: AnyObject {
    func showProducts(_ products: [Product])
    func showError(_ message: String)
    func setLoading(_ isLoading: Bool)
    func updateCartBadge(count: Int)
}

// MARK: - Presenter
protocol ProductListPresenterProtocol: AnyObject {
    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorInputProtocol? { get set }
    var router: ProductListRouterProtocol? { get set }
    
    func viewDidLoad()
    func didSelectProduct(_ product: Product)
    func addToCart(_ product: Product)
    func removeFromCart(_ product: Product)
    func isProductInCart(_ product: Product) -> Bool
}

// MARK: - Interactor

protocol ProductListInteractorInputProtocol: AnyObject {
    var presenter: ProductListInteractorOutputProtocol? { get set }
    
    func fetchProducts()
    func addToCart(_ product: Product)
    func removeFromCart(_ product: Product)
    func isProductInCart(_ product: Product) -> Bool
}

protocol ProductListInteractorOutputProtocol: AnyObject {
    func productsFetched(_ products: [Product])
    func productsFetchFailed(_ error: Error)
    func cartUpdated()
}

// MARK: - Router
protocol ProductListRouterProtocol: AnyObject {
    static func createProductListModule() -> UIViewController
    func presentProductDetail(from view: ProductListViewProtocol?, for product: Product)
}
