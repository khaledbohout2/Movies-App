
import Combine
import Foundation
@testable import MoviesApp

final class MockMoviesRepository: MoviesRepository {

    var popularMoviesResult: Result<Movies, APIError>?
    var searchMoviesResult: Result<Movies, APIError>?
    var movieDetailsResult: Result<Movie, APIError>?
    var similarMoviesResult: Result<Movies, APIError>?
    var movieCreditsResult: Result<MovieCredits, APIError>?

    var addedMovieID: Int?
    var removedMovieID: Int?
    
    private var wishlistedMovieIDs: Set<Int> = []

    func getPopularMovies(page: Int) -> AnyPublisher<Movies, APIError> {
        return publisher(for: popularMoviesResult)
    }

    func searchMovies(query: String, page: Int) -> AnyPublisher<Movies, APIError> {
        return publisher(for: searchMoviesResult)
    }

    func getMovieDetails(id: Int) -> AnyPublisher<Movie, APIError> {
        return publisher(for: movieDetailsResult)
    }

    func getSimilarMovies(id: Int) -> AnyPublisher<Movies, APIError> {
        return publisher(for: similarMoviesResult)
    }

    func getMovieCredits(id: Int) -> AnyPublisher<MovieCredits, APIError> {
        return publisher(for: movieCreditsResult)
    }

    func addToWishlist(movieID: Int) {
        addedMovieID = movieID
    }

    func removeFromWishlist(movieID: Int) {
        removedMovieID = movieID
    }
    
    func wishListContains(movieID: Int) -> Bool {
        return wishlistedMovieIDs.contains(movieID)
    }

    private func publisher<T>(for result: Result<T, APIError>?) -> AnyPublisher<T, APIError> {
        guard let result = result else {
            return Fail(error: APIError.unknown(NSError(
                domain: "MockMoviesRepository",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No result set in mock"]
            )))
            .eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }

}

