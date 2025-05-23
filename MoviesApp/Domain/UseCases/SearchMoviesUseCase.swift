
import Combine

protocol SearchMoviesUseCase {
    func perform(query: String, page: Int) -> AnyPublisher<Movies, APIError>
}

final class SearchMoviesUseCaseImp: SearchMoviesUseCase {

    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func perform(query: String, page: Int) -> AnyPublisher<Movies, APIError> {
        return moviesRepository.searchMovies(query: query, page: page)
    }

}
