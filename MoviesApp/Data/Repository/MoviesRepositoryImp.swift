
import Combine

class MoviesRepositoryImp: MoviesRepository {
    private var apiClient: APIClientProtocol
    private var wishlistStorage: WishlistStorage

    init(apiClient: APIClientProtocol, wishlistStorage: WishlistStorage) {
        self.apiClient = apiClient
        self.wishlistStorage = wishlistStorage
    }

    func getPopularMovies(page: Int) -> AnyPublisher<MovieResponse, APIError> {
        return apiClient.request(MovieAPI.popular(page: page), responseType: MovieResponse.self)
            .map { [weak self] response -> MovieResponse in
                guard let self = self else { return response }
                let updatedMovies = response.results.map { movie -> Movie in
                    var newMovie = movie
                    newMovie.isWishlisted = self.wishlistStorage.contains(movieID: newMovie.id)
                    return newMovie
                }
                return MovieResponse(results: updatedMovies, page: response.page, totalPages: response.totalPages)
            }
            .eraseToAnyPublisher()
    }

    func searchMovies(query: String, page: Int) -> AnyPublisher<MovieResponse, APIError> {
        return apiClient.request(MovieAPI.search(query: query, page: page), responseType: MovieResponse.self)
            .map { [weak self] response -> MovieResponse in
                guard let self = self else { return response }
                let updatedMovies = response.results.map { movie -> Movie in
                    var newMovie = movie
                    newMovie.isWishlisted = self.wishlistStorage.contains(movieID: newMovie.id)
                    return newMovie
                }
                return MovieResponse(results: updatedMovies, page: response.page, totalPages: response.totalPages)
            }
            .eraseToAnyPublisher()
    }

    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, APIError> {
        return apiClient.request(MovieAPI.getMovieDetails(id: id), responseType: Movie.self)
            .map { [weak self] movie -> Movie in
                var newMovie = movie
                newMovie.isWishlisted = self?.wishlistStorage.contains(movieID: newMovie.id) ?? false
                return newMovie
            }
            .eraseToAnyPublisher()
    }

    func fetchSimilarMovies(id: Int) -> AnyPublisher<MovieResponse, APIError> {
        return apiClient.request(MovieAPI.getSimilarMovies(id: id), responseType: MovieResponse.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCreditsResponse, APIError> {
        return apiClient.request(MovieAPI.getMovieCredits(id: id), responseType: MovieCreditsResponse.self)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    func addToWishlist(movieID: Int) {
        wishlistStorage.add(movieID: movieID)
    }

    func removeFromWishlist(movieID: Int) {
        wishlistStorage.remove(movieID: movieID)
    }

}
