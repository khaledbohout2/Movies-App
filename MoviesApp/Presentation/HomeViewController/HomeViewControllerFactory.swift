//
//  HomeViewControllerFactory.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import UIKit

protocol HomeViewControllerFactory {
    func makeHomeViewController(coordinator: Coordinator) -> UIViewController
}

class DefaultHomeViewControllerFactory: HomeViewControllerFactory {
    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }

    func makeHomeViewController(coordinator: Coordinator) -> UIViewController {
        let viewModel = HomeViewModel(
            coordinator: coordinator,
            getpopularMoviesUseCase: container.getPopularMoviesUseCase,
            getsearchMoviesUseCase: container.searchMoviesUseCase
        )
        return HomeVC(viewModel: viewModel)
    }
}
