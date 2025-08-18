//
//  CartViewEntity.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation

struct CartItem {
    let product: Product
    var quantity: Int
    
    var totalPrice: Double {
        return product.price * Double(quantity)
    }
}
