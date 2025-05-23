
import Foundation

protocol RemoveFromWishlistUseCase {
    func execute(movieID: Int)
}

final class RemoveFromWishlistUseCaseImp: RemoveFromWishlistUseCase {
    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func execute(movieID: Int) {
        moviesRepository.removeFromWishlist(movieID: movieID)
    }
}
