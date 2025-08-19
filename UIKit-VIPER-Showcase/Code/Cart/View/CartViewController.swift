//
//  CartViewController.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 18.08.2025.
//

import UIKit

class CartViewController: UIViewController, CartViewProtocol {
    
    // MARK: - Properties
    var presenter: CartPresenterProtocol?
    private var cartItems: [CartItem] = []
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.reuseIdentifier)
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let totalView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let itemCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ödemeye Geç", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = "Sepetim"
        view.backgroundColor = .systemBackground
        
        // TableView Setup
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Total View Setup
        view.addSubview(totalView)
        totalView.addSubview(totalLabel)
        totalView.addSubview(itemCountLabel)
        totalView.addSubview(checkoutButton)
        
        // Layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        totalView.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        itemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // TableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalView.topAnchor),
            
            // Total View
            totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 100),
            
            // Total Label
            totalLabel.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 16),
            totalLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 16),
            
            // Item Count Label
            itemCountLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 4),
            itemCountLabel.leadingAnchor.constraint(equalTo: totalLabel.leadingAnchor),
            
            // Checkout Button
            checkoutButton.centerYAnchor.constraint(equalTo: totalView.centerYAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -16),
            checkoutButton.widthAnchor.constraint(equalToConstant: 150),
            checkoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - CartViewProtocol
    func showCartItems(_ items: [CartItem]) {
        cartItems = items
        tableView.reloadData()
    }
    
    func updateCartTotal(price: Double, itemCount: Int) {
        totalLabel.text = "Toplam: \(price) ₺"
        itemCountLabel.text = "\(itemCount) ürün"
        
        // Update tab bar badge
        tabBarController?.tabBar.items?[1].badgeValue = itemCount > 0 ? "\(itemCount)" : nil
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    @objc private func checkoutButtonTapped() {
        presenter?.checkout()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.reuseIdentifier, for: indexPath) as? CartItemCell else {
            return UITableViewCell()
        }
        
        let item = cartItems[indexPath.row]
        cell.configure(with: item) { [weak self] newQuantity in
            self?.presenter?.updateQuantity(for: item.product, quantity: newQuantity)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = cartItems[indexPath.row]
            presenter?.removeItem(item.product)
        }
    }
}
