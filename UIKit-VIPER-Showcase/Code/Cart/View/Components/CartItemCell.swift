//
//  CartItemCell.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class CartItemCell: UITableViewCell {
    
    static let reuseIdentifier = "CartItemCell"
    
    // MARK: - Properties
    private var quantityChangedHandler: ((Int) -> Void)?
    private var currentItem: CartItem?
    
    // MARK: - UI Components
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemBlue
        return label
    }()
    
    private let quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 99
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(quantityChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        // Stack View for quantity controls
        stackView.addArrangedSubview(quantityStepper)
        stackView.addArrangedSubview(quantityLabel)
        contentView.addSubview(stackView)
        
        // Layout
        productImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView)
            make.left.equalTo(productImageView.snp.right).offset(12)
            make.right.lessThanOrEqualToSuperview().offset(-16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
        
        stackView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    func configure(with item: CartItem, quantityChanged: @escaping (Int) -> Void) {
        currentItem = item
        quantityChangedHandler = quantityChanged
        
        titleLabel.text = item.product.name
        priceLabel.text = item.product.price.currencyFormatted
        quantityStepper.value = Double(item.quantity)
        quantityLabel.text = "\(item.quantity)"
        
        // Load image using Kingfisher
        if let imageUrl = URL(string: item.product.imageURL) {
            productImageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "photo"))
        }
    }
    
    // MARK: - Actions
    @objc private func quantityChanged(_ sender: UIStepper) {
        let quantity = Int(sender.value)
        quantityLabel.text = "\(quantity)"
        quantityChangedHandler?(quantity)
    }
}

// Currency formatter extension is already defined in Product.swift
