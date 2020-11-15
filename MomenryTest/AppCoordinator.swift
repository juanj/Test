//
//  AppCoordinator.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

class AppCoordinator {
    private var productsViewController: ProductsViewController?

    private let navigationController: UINavigationController
    private let productsService: ProductsServiceable
    private let imageDownloader: ImageDownloader

    init(navigationController: UINavigationController, productsService: ProductsServiceable, imageDownloader: ImageDownloader) {
        self.navigationController = navigationController
        self.productsService = productsService
        self.imageDownloader = imageDownloader
    }

    func start() {
        let productsViewController = ProductsViewController(delegate: self, imageDownloader: imageDownloader)
        navigationController.pushViewController(productsViewController, animated: false)

        self.productsViewController = productsViewController
        loadProducts()
    }

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        navigationController.present(alert, animated: true, completion: nil)
    }

    private func loadProducts() {
        productsService.getProducts { result in
            switch result {
            case .success(let response):
                self.productsViewController?.products = response.data
            case .failure(let error):
                self.showError(error)
            }
        }
    }
}

extension AppCoordinator: ProductsViewcontrollerDelegate {
    func didSelectProduct(_ productsViewController: ProductsViewController, product: Product) {
        navigationController.pushViewController(ProductDetailViewController(product: product, imageDownloader: imageDownloader), animated: true)
    }
}
