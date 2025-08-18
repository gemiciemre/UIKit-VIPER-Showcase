import Foundation

struct Product: Codable, Equatable {
    let id: String
    let name: String
    let price: Double
    let description: String
    let category: String
    let imageURL: String
    let rating: Double
    let reviewCount: Int
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Currency Formatting
extension Double {
    func formatAsTurkishLira() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: self)) ?? "\(self) ₺"
    }
}
