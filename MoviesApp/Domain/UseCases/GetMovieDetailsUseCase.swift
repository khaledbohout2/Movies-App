
import Combine

protocol GetMovieDetailsUseCase {
    func execute(movieId: Int) -> AnyPublisher<Movie, APIError>
}

class GetMovieDetailsUseCaseImp: GetMovieDetailsUseCase {
    private let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func execute(movieId: Int) -> AnyPublisher<Movie, APIError> {
        repository.getMovieDetails(id: movieId)
    }
}
