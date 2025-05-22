
import Combine

protocol MoviesRepository {
    func getPopularMovies(page: Int) -> AnyPublisher<MovieResponse, Error>
    func searchMovies(query: String, page: Int) -> AnyPublisher<MovieResponse, Error>
    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, Error>
    func fetchSimilarMovies(id: Int) -> AnyPublisher<MovieResponse, Error>
    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCreditsResponse, Error>
}
