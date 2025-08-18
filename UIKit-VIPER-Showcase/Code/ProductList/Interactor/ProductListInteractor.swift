import Foundation

final class ProductListInteractor: ProductListInteractorInputProtocol {
    weak var presenter: ProductListInteractorOutputProtocol?
    private let productService: ProductServiceProtocol
    private var products: [Product] = []
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
        setupCartObserver()
    }
    
    deinit {
        Cart.shared.removeCartUpdateObserver(self)
    }
    
    func fetchProducts() {
        productService.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productsDTO):
                    self?.products = productsDTO.map { $0.toDomain() }
                    self?.presenter?.productsFetched(self?.products ?? [])
                case .failure(let error):
                    self?.presenter?.productsFetchFailed(error)
                }
            }
        }
    }
    
    func addToCart(_ product: Product) {
        Cart.shared.addToCart(product)
    }
    
    func removeFromCart(_ product: Product) {
        Cart.shared.removeFromCart(product)
    }
    
    func isProductInCart(_ product: Product) -> Bool {
        return Cart.shared.isProductInCart(product)
    }
    
    private func setupCartObserver() {
        Cart.shared.addCartUpdateObserver(self, selector: #selector(cartDidUpdate))
    }
    
    @objc private func cartDidUpdate() {
        presenter?.cartUpdated()
    }
}
