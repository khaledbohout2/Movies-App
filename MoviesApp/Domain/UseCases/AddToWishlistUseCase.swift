
import Foundation

protocol AddToWishlistUseCase {
    func execute(movieID: Int)
}

final class AddToWishlistUseCaseImp: AddToWishlistUseCase {
    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func execute(movieID: Int) {
        moviesRepository.addToWishlist(movieID: movieID)
    }
}

