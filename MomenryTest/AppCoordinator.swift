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
        navigationController.pushViewController(UIViewController(), animated: false)
    }
}
