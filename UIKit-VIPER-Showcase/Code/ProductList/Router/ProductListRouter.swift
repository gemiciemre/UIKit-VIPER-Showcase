import UIKit

class ProductListRouter: ProductListRouterProtocol {
    static func createProductListModule() -> UIViewController {
        let view = ProductListViewController()
        let presenter: ProductListPresenterProtocol & ProductListInteractorOutputProtocol = ProductListPresenter()
        let interactor: ProductListInteractorInputProtocol = ProductListInteractor()
        let router: ProductListRouterProtocol = ProductListRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    func navigateToProductDetail(from view: ProductListViewProtocol?, with product: Product) {
        guard let viewController = view as? UIViewController else { return }
        let detailVC = ProductDetailRouter.createProductDetailModule(with: product)
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
