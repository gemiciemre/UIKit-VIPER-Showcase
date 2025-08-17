//
//  ProductDetailViewController.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    // MARK: - UI Elements
       private let scrollView = UIScrollView()
       private let contentView = UIView()
       private let productImageView = UIImageView()
       private let titleLabel = UILabel()
       private let priceLabel = UILabel()
       private let descriptionLabel = UILabel()
       private let addToCartButton = UIButton(type: .system)
//       private let ratingView = RatingView()
    
    var presenter: ProductDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupProductImageView()
        setupLabels()
        setupAddToCartButton()
        setupConstraints()
    }
}

// MARK: - Presenter Methods
extension ProductDetailViewController: ProductDetailViewProtocol {
    func showProduct(_ product: Product) {
        titleLabel.text = product.name
        priceLabel.text = "\(product.price) ₺"
        descriptionLabel.text = product.description
        
        if let imageURL = URL(string: product.imageURL) {
            productImageView.kf.setImage(
                with: imageURL,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
            productImageView.contentMode = .scaleAspectFill
            productImageView.clipsToBounds = true
        }
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    func updateCartButton(isInCart: Bool) {
        let title = isInCart ? "Sepetten Çıkar" : "Sepete Ekle"
        let color: UIColor = isInCart ? .systemRed : .systemBlue
        addToCartButton.setTitle(title, for: .normal)
        addToCartButton.backgroundColor = color
    }
}

// MARK: - Actions
extension ProductDetailViewController {
    @objc private func addToCartTapped() {
        presenter?.addToCartButtonTapped()
    }
}

// MARK: - UI Elements Setup

extension ProductDetailViewController {
    private func setupProductImageView() {
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 12
        productImageView.backgroundColor = .systemGray6
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImageView)
    }
    
    private func setupLabels() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        
        priceLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        priceLabel.textColor = .systemGreen
        
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        
        [titleLabel, priceLabel, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupAddToCartButton() {
        addToCartButton.setTitle("Sepete Ekle", for: .normal)
        addToCartButton.backgroundColor = .systemBlue
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.layer.cornerRadius = 8
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addToCartButton)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }

    @objc private func refreshData() {
        presenter?.refreshData()
    }
}

// MARK: - Constraints Setup

extension ProductDetailViewController {
    private func setupConstraints() {
        // ScrollView ve contentView için constraintler
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Product Image
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            productImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            // Price Label
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            
            // Description Label
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            // Add to Cart Button
            addToCartButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            addToCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
