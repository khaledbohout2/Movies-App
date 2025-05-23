
import Combine

protocol GetPopularMoviesUseCase {
    func perform(page: Int) -> AnyPublisher<MovieResponse, APIError>
}

final class GetPopularMoviesUseCaseImp: GetPopularMoviesUseCase {

    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func perform(page: Int) -> AnyPublisher<MovieResponse, APIError> {
        return moviesRepository.getPopularMovies(page: page)
    }
}
