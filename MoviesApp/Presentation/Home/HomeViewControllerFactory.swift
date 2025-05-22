
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
            getPopularMoviesUseCase: container.getPopularMoviesUseCase,
            getsearchMoviesUseCase: container.searchMoviesUseCase
        )
        return HomeVC(viewModel: viewModel)
    }
}
