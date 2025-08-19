//
//  ProductCell.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import Foundation
import UIKit
import Kingfisher

final class ProductCell: UITableViewCell {
    static let reuseIdentifier = "ProductCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var cartButtonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.kf.cancelDownloadTask()
        productImageView.image = nil
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(addToCartButton)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        productImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(12)
            make.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView)
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.bottom.equalTo(productImageView)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
    }
    
    func configure(with product: Product, isInCart: Bool, cartButtonAction: @escaping () -> Void) {
        self.cartButtonAction = cartButtonAction
        
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₺" //product.price.formatAsTurkishLira()
        
        if let imageURL = URL(string: product.imageURL) {
            productImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeholder"))
        }
        
        updateCartButton(isInCart: isInCart)
    }
    
    private func updateCartButton(isInCart: Bool) {
        let imageName = isInCart ? "checkmark.circle.fill" : "cart.badge.plus"
        let color: UIColor = isInCart ? .systemGreen : .systemBlue
        
        addToCartButton.setImage(UIImage(systemName: imageName), for: .normal)
        addToCartButton.backgroundColor = color
    }
    
    @objc private func cartButtonTapped() {
        cartButtonAction?()
    }
}
