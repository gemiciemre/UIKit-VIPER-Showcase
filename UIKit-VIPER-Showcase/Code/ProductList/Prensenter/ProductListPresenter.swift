import Foundation

class ProductListPresenter: ProductListPresenterProtocol {
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorInputProtocol?
    var router: ProductListRouterProtocol?
    
    private var products: [Product] = []

    func viewDidLoad() {
        interactor?.fetchProducts()
    }

    func didSelectProduct(_ product: Product) {
        router?.presentProductDetail(from: view, for: product)
    }
    
    func addToCart(_ product: Product) {
        interactor?.addToCart(product)
    }
    
    func removeFromCart(_ product: Product) {
        interactor?.removeFromCart(product)
    }
    
    func isProductInCart(_ product: Product) -> Bool {
        return interactor?.isProductInCart(product) ?? false
    }
}

extension ProductListPresenter: ProductListInteractorOutputProtocol {
    func productsFetched(_ products: [Product]) {
        self.products = products
        view?.showProducts(products)
    }
    
    func productsFetchFailed(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            view?.setLoading(true)
        } else {
            view?.setLoading(false)
        }
    }
    
    func updateCartBadge(count: Int) {
        view?.updateCartBadge(count: count)
    }
    
    func cartUpdated() {
        // Update cart badge with current count
        let cartCount = Cart.shared.getTotalItemCount()
        view?.updateCartBadge(count: cartCount)
        
        // Refresh the visible cells to update the cart button state
//        view?.refreshProducts()
    }
}
