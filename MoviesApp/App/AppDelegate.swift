//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setAppearance()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        
        let container = DependencyContainer()
        let homeFactory = DefaultHomeViewControllerFactory(container: container)
        let coordinator = AppCoordinator(navigationController: navController, homeFactory: homeFactory)

        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        coordinator.start()

        return true
    }
}
