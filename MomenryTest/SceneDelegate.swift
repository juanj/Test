//
//  SceneDelegate.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let rootNavigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: rootNavigationController, productsService: ProductsService())
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()

        appCoordinator.start()
    }
}
