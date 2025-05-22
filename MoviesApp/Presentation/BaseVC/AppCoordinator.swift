
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func showMovieDetails(movieId: Int)
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let homeFactory: HomeViewControllerFactory
    private let movieDetailsFactory: MovieDetailsFactory

    init(navigationController: UINavigationController,
         homeFactory: HomeViewControllerFactory,
         movieDetailsFactory: MovieDetailsFactory) {
        self.navigationController = navigationController
        self.homeFactory = homeFactory
        self.movieDetailsFactory = movieDetailsFactory
    }

    func start() {
        let mainVC = homeFactory.makeHomeViewController(coordinator: self)
        navigationController.pushViewController(mainVC, animated: false)
    }

    func showMovieDetails(movieId: Int) {
        let movieDetailsVC = movieDetailsFactory.makeMovieDetailsViewController(movieId: movieId, coordinator: self)
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}
