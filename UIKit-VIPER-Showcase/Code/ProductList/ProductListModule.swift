import UIKit

class ProductListModule {
    static func createModule() -> UIViewController {
        let view = ProductListViewController()
        let presenter = ProductListPresenter()
        let interactor = ProductListInteractor()
        let router = ProductListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
}
