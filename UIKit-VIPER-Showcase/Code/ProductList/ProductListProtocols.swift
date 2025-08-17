import Foundation
import UIKit

// MARK: - View
protocol ProductListViewProtocol: AnyObject {
    func showProducts(products: [Product])
    func showError(message: String)
}

// MARK: - Presenter
protocol ProductListPresenterProtocol: AnyObject {
    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorInputProtocol? { get set }
    var router: ProductListRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectProduct(product: Product)
}

// MARK: - Interactor

protocol ProductListInteractorInputProtocol: AnyObject {
    var presenter: ProductListInteractorOutputProtocol? { get set }
    func fetchProducts()
}

protocol ProductListInteractorOutputProtocol: AnyObject {
    func productsFetched(products: [Product])
    func productsFetchFailed(error: NetworkError)
}

// MARK: - Router
protocol ProductListRouterProtocol: AnyObject {
    static func createProductListModule() -> UIViewController
    func navigateToProductDetail(from view: ProductListViewProtocol?, with product: Product)
}
