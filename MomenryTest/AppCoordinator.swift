//
//  AppCoordinator.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

class AppCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let productsViewController = ProductsViewController(delegate: self, products: [.init(url: "", name: "Test")])
        navigationController.pushViewController(productsViewController, animated: false)
    }
}

extension AppCoordinator: ProductsViewcontrollerDelegate {
    func didSelectProduct(_ productsViewController: ProductsViewController, product: Product) {}
}
