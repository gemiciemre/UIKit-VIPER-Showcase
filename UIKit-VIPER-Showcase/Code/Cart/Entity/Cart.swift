import Foundation

class Cart {
    static let shared = Cart()
    
    private var items: [CartItem] = []
    private let cartUpdatedNotification = Notification.Name("CartUpdated")
    
    private init() {}
    
    // MARK: - Public Methods
    func addToCart(_ product: Product) {
        if let existingIndex = items.firstIndex(where: { $0.product.id == product.id }) {
            items[existingIndex].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
        notifyCartUpdated()
    }
    
    func removeFromCart(_ product: Product) {
        items.removeAll { $0.product.id == product.id }
        notifyCartUpdated()
    }
    
    func updateQuantity(for product: Product, quantity: Int) {
        if quantity <= 0 {
            removeFromCart(product)
            return
        }
        
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity = quantity
            notifyCartUpdated()
        }
    }
    
    func isProductInCart(_ product: Product) -> Bool {
        return items.contains { $0.product.id == product.id }
    }
    
    func getCartItems() -> [CartItem] {
        return items
    }
    
    func getTotalPrice() -> Double {
        return items.reduce(0) { $0 + $1.totalPrice }
    }
    
    func getTotalItemCount() -> Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
    
    func clearCart() {
        items.removeAll()
        notifyCartUpdated()
    }
    
    // MARK: - Notification
    private func notifyCartUpdated() {
        NotificationCenter.default.post(name: cartUpdatedNotification, object: nil)
    }
    
    func addCartUpdateObserver(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: cartUpdatedNotification,
            object: nil
        )
    }
    
    func removeCartUpdateObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer, name: cartUpdatedNotification, object: nil)
    }
}
