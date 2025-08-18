import Foundation
import UIKit

// MARK: - View Protocol
protocol ProductDetailViewProtocol: AnyObject {
    func showProduct(_ product: Product)
    func showError(_ message: String)
    func updateCartButton(isInCart: Bool)
}

// MARK: - Presenter Protocol
protocol ProductDetailPresenterProtocol: AnyObject {
    var view: ProductDetailViewProtocol? { get set }
    var interactor: ProductDetailInteractorInputProtocol? { get set }
    var router: ProductDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func addToCartButtonTapped()
    func refreshData()
}

// MARK: - Interactor Protocols
protocol ProductDetailInteractorInputProtocol: AnyObject {
    var presenter: ProductDetailInteractorOutputProtocol? { get set }
    
    func fetchProductDetails()
    func toggleCartStatus()
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func productDetailsFetched()
    func productDetailsFetchFailed(error: Error)
    func cartStatusUpdated(isInCart: Bool)
}

// MARK: - Router Protocol
protocol ProductDetailRouterProtocol: AnyObject {
    static func createProductDetailModule(with product: Product) -> UIViewController
    func navigateBack(from view: ProductDetailViewProtocol?)
}
