
import Combine

protocol GetSimilarMoviesUseCase {
    func execute(movieId: Int) -> AnyPublisher<[Movie], Error>
}

class GetSimilarMoviesUseCaseImp: GetSimilarMoviesUseCase {
    private let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func execute(movieId: Int) -> AnyPublisher<[Movie], Error> {
        repository.fetchSimilarMovies(id: movieId)
            .map { response in
                Array(response.results.prefix(5))
            }
            .eraseToAnyPublisher()
    }

}
