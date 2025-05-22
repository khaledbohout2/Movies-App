
import Combine

protocol GetSimilarMoviesUseCase {
    func execute(movieId: Int) -> AnyPublisher<MovieResponse, Error>
}

class GetSimilarMoviesUseCaseImp: GetSimilarMoviesUseCase {
    private let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func execute(movieId: Int) -> AnyPublisher<MovieResponse, Error> {
        repository.fetchSimilarMovies(id: movieId)
    }
}
