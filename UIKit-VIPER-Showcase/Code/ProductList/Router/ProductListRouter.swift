import UIKit

final class ProductListRouter: ProductListRouterProtocol {
    
    // MARK: - Static Methods
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
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    // MARK: - Navigation
    func presentProductDetail(from view: ProductListViewProtocol?, for product: Product) {
        guard let viewController = (view as? UIViewController)?.navigationController?.topViewController else { return }
        let detailVC = ProductDetailRouter.createProductDetailModule(with: product)
        detailVC.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
