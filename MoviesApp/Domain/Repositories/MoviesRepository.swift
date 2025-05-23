
import Combine

protocol MoviesRepository {
    func getPopularMovies(page: Int) -> AnyPublisher<Movies, APIError>
    func searchMovies(query: String, page: Int) -> AnyPublisher<Movies, APIError>
    func getMovieDetails(id: Int) -> AnyPublisher<Movie, APIError>
    func getSimilarMovies(id: Int) -> AnyPublisher<Movies, APIError>
    func getMovieCredits(id: Int) -> AnyPublisher<MovieCredits, APIError>
    func addToWishlist(movieID: Int)
    func removeFromWishlist(movieID: Int)
    func wishListContains(movieID: Int) -> Bool
}
