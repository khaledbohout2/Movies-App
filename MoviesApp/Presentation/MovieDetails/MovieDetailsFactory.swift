
import UIKit

protocol MovieDetailsFactory {
    func makeMovieDetailsViewController(movieId: Int, coordinator: Coordinator) -> UIViewController
}

class DefaultMovieDetailsFactory: MovieDetailsFactory {
    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }

    func makeMovieDetailsViewController(movieId: Int, coordinator: Coordinator) -> UIViewController {
        let viewModel = MovieDetailsViewModel(movieId: movieId,
                                              coordinator: coordinator,
                                              getmovieDetailsUseCase: container.getMovieDetailsUseCase,
                                              getsimilarMoviesUseCase: container.getSimilarMoviesUseCase,
                                              getCastsOfSimilarMoviesUseCase: container.getCastsOfSimilarMoviesUseCase,
                                              addToWishlistUseCase: container.addMovieToWishlistUseCase,
                                              removeFromWishlistUseCase: container.removeFromWishlistUseCase)
        return MovieDetailsVC(viewModel: viewModel)
    }

}
