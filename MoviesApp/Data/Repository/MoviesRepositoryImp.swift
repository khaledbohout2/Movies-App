
import Combine

final class MoviesRepositoryImp: MoviesRepository {
    private var apiClient: APIClientProtocol
    private var wishlistStorage: WishlistStorage

    init(apiClient: APIClientProtocol, wishlistStorage: WishlistStorage) {
        self.apiClient = apiClient
        self.wishlistStorage = wishlistStorage
    }

    func getPopularMovies(page: Int) -> AnyPublisher<Movies, APIError> {
        return apiClient.request(MovieAPI.popular(page: page), responseType: Movies.self)
            .map { [weak self] response -> Movies in
                guard let self = self else { return response }
                let updatedMovies = response.results.map { movie -> Movie in
                    var newMovie = movie
                    newMovie.isWishlisted = self.wishlistStorage.contains(movieID: newMovie.id)
                    return newMovie
                }
                return Movies(results: updatedMovies, page: response.page, totalPages: response.totalPages)
            }
            .eraseToAnyPublisher()
    }

    func searchMovies(query: String, page: Int) -> AnyPublisher<Movies, APIError> {
        return apiClient.request(MovieAPI.search(query: query, page: page), responseType: Movies.self)
            .map { [weak self] response -> Movies in
                guard let self = self else { return response }
                let updatedMovies = response.results.map { movie -> Movie in
                    var newMovie = movie
                    newMovie.isWishlisted = self.wishlistStorage.contains(movieID: newMovie.id)
                    return newMovie
                }
                return Movies(results: updatedMovies, page: response.page, totalPages: response.totalPages)
            }
            .eraseToAnyPublisher()
    }

    func getMovieDetails(id: Int) -> AnyPublisher<Movie, APIError> {
        return apiClient.request(MovieAPI.getMovieDetails(id: id), responseType: Movie.self)
            .map { [weak self] movie -> Movie in
                var newMovie = movie
                newMovie.isWishlisted = self?.wishlistStorage.contains(movieID: newMovie.id) ?? false
                return newMovie
            }
            .eraseToAnyPublisher()
    }

    func getSimilarMovies(id: Int) -> AnyPublisher<Movies, APIError> {
        return apiClient.request(MovieAPI.getSimilarMovies(id: id), responseType: Movies.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func getMovieCredits(id: Int) -> AnyPublisher<MovieCredits, APIError> {
        return apiClient.request(MovieAPI.getMovieCredits(id: id), responseType: MovieCredits.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func addToWishlist(movieID: Int) {
        wishlistStorage.add(movieID: movieID)
    }

    func removeFromWishlist(movieID: Int) {
        wishlistStorage.remove(movieID: movieID)
    }
    
    func wishListContains(movieID: Int) -> Bool {
        return wishlistStorage.contains(movieID: movieID)
    }

}
