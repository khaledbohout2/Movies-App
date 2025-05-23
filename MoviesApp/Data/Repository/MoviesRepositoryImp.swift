
import Combine

class MoviesRepositoryImp: MoviesRepository {
    private var apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func getPopularMovies(page: Int) -> AnyPublisher<MovieResponse, Error> {
        return apiClient.request(MovieAPI.popular(page: page), responseType: MovieResponse.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func searchMovies(query: String, page: Int) -> AnyPublisher<MovieResponse, Error> {
        return apiClient.request(MovieAPI.search(query: query, page: page), responseType: MovieResponse.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, Error> {
        return apiClient.request(MovieAPI.getMovieDetails(id: id), responseType: Movie.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func fetchSimilarMovies(id: Int) -> AnyPublisher<MovieResponse, Error> {
        return apiClient.request(MovieAPI.getSimilarMovies(id: id), responseType: MovieResponse.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCreditsResponse, Error> {
        return apiClient.request(MovieAPI.getMovieCredits(id: id), responseType: MovieCreditsResponse.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

}
