//
//  ProductsViewController.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

protocol ProductsViewcontrollerDelegate: AnyObject {
    func didSelectProduct(_ productsViewController: ProductsViewController, product: Product)
}

class ProductsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var products = [Product]() {
        didSet {
            tableView.reloadData()
        }
    }

    private weak var delegate: ProductsViewcontrollerDelegate?
    private let imageDownloader: ImageDownloader

    init(delegate: ProductsViewcontrollerDelegate, imageDownloader: ImageDownloader, products: [Product] = []) {
        self.delegate = delegate
        self.imageDownloader = imageDownloader
        self.products = products
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        title = "Productos"
        configureTableView()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productCell")
        tableView.rowHeight = 300
    }
}

extension ProductsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as? ProductTableViewCell else {
            fatalError("Error trying to dequeue cell of type ProductTableViewCell")
        }

        let product = products[indexPath.row]
        cell.nameLabel.text = product.name

        if let url = URL(string: product.url) {
            imageDownloader.downloadImageFromUrl(url) { image in
                cell.productImageView.image = image
            }
        }

        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectProduct(self, product: products[indexPath.row])
    }
}
