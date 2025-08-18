import UIKit

class ProductListViewController: UIViewController {
    var presenter: ProductListPresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemBackground
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
         let indicator = UIActivityIndicatorView(style: .large)
         indicator.translatesAutoresizingMaskIntoConstraints = false
         indicator.hidesWhenStopped = true
         return indicator
     }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private var products: [Product] = []
    private var cartButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Ürünler"
        setupTableView()
        setupCartButton()
        setupActivityIndicator()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        title = "Products"
    }
    private func setupCartButton() {
        let cartButton = UIButton(type: .system)
        cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        self.cartButton = UIBarButtonItem(customView: cartButton)
        navigationItem.rightBarButtonItem = self.cartButton
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func refreshData() {
        presenter?.viewDidLoad()
    }
    
    @objc private func cartButtonTapped() {
        // Switch to cart tab
        tabBarController?.selectedIndex = 1
    }
}

extension ProductListViewController: ProductListViewProtocol {
    
    func showProducts(_ products: [Product]) {
        self.products = products
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        refreshControl.endRefreshing()
    }
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func updateCartBadge(count: Int) {
        if let cartButton = cartButton?.customView as? UIButton {
            let badgeLabel = UILabel()
            badgeLabel.text = count > 0 ? "\(count)" : nil
            badgeLabel.textColor = .white
            badgeLabel.backgroundColor = .red
            badgeLabel.textAlignment = .center
            badgeLabel.font = .systemFont(ofSize: 12, weight: .bold)
            badgeLabel.layer.cornerRadius = 8
            badgeLabel.clipsToBounds = true
            
            // Remove existing badge if any
            cartButton.subviews.forEach { if $0 is UILabel { $0.removeFromSuperview() } }
            
            if count > 0 {
                cartButton.addSubview(badgeLabel)
                badgeLabel.snp.makeConstraints { make in
                    make.top.trailing.equalToSuperview().inset(-6)
                    make.width.height.equalTo(16)
                }
            }
        }
    }
    
    func refreshProducts() {
        tableView.reloadData()
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        let product = products[indexPath.row]
        let isInCart = presenter?.isProductInCart(product) ?? false
        
        cell.configure(with: product, isInCart: isInCart) { [weak self] in
            if isInCart {
                self?.presenter?.removeFromCart(product)
            } else {
                self?.presenter?.addToCart(product)
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = products[indexPath.row]
        presenter?.didSelectProduct(product)
    }
}
