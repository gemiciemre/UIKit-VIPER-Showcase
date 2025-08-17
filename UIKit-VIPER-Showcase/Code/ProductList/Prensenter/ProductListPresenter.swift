import Foundation

class ProductListPresenter: ProductListPresenterProtocol {
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorInputProtocol?
    var router: ProductListRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchProducts()
    }

    func didSelectProduct(product: Product) {
        router?.navigateToProductDetail(from: view, with: product)
    }
}

extension ProductListPresenter: ProductListInteractorOutputProtocol {
    func productsFetched(products: [Product]) {
        view?.showProducts(products: products)
    }

    func productsFetchFailed(error: NetworkError) {
        view?.showError(message: error.errorMessage)
    }
}


