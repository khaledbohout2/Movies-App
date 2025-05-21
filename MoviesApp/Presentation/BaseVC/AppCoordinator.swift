//
//  AppCoordinator.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeFactory: HomeViewControllerFactory

    init(navigationController: UINavigationController, homeFactory: HomeViewControllerFactory) {
        self.navigationController = navigationController
        self.homeFactory = homeFactory
    }

    func start() {
        let mainVC = homeFactory.makeHomeViewController(coordinator: self)
        navigationController.pushViewController(mainVC, animated: false)
    }
}
