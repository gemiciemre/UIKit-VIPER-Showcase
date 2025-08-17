import Foundation

final class ProductListInteractor: ProductListInteractorInputProtocol {
    weak var presenter: ProductListInteractorOutputProtocol?
    private let productService: ProductServiceProtocol
    private var products: [Product] = []
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func fetchProducts() {
        productService.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productsDTO):
                    self?.products = productsDTO.map { $0.toDomain() }
                    self?.presenter?.productsFetched(products: self?.products ?? [])
                case .failure(let error):
                    self?.presenter?.productsFetchFailed(error: error)
                }
            }
        }
    }
    
    func refreshProducts() {
        fetchProducts()
    }
    
    func getProduct(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else { return nil }
        return products[index]
    }
}
