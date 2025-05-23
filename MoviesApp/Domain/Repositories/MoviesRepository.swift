
import Combine

protocol MoviesRepository {
    func getPopularMovies(page: Int) -> AnyPublisher<MovieResponse, APIError>
    func searchMovies(query: String, page: Int) -> AnyPublisher<MovieResponse, APIError>
    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, APIError>
    func fetchSimilarMovies(id: Int) -> AnyPublisher<MovieResponse, APIError>
    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCreditsResponse, APIError>
    func addToWishlist(movieID: Int)
    func removeFromWishlist(movieID: Int)
    func wishListContains(movieID: Int) -> Bool
}
