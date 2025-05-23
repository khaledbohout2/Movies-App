
import Combine
import Foundation
@testable import MoviesApp

final class MockMoviesRepository: MoviesRepository {
    var popularMoviesResult: Result<MovieResponse, Error>?
    var searchMoviesResult: Result<MovieResponse, Error>?
    var movieDetailsResult: Result<Movie, Error>?
    var similarMoviesResult: Result<MovieResponse, Error>?
    var movieCreditsResult: Result<MovieCreditsResponse, Error>?

    var addedMovieID: Int?
    var removedMovieID: Int?

    func getPopularMovies(page: Int) -> AnyPublisher<MovieResponse, Error> {
        return publisher(for: popularMoviesResult)
    }

    func searchMovies(query: String, page: Int) -> AnyPublisher<MovieResponse, Error> {
        return publisher(for: searchMoviesResult)
    }

    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, Error> {
        return publisher(for: movieDetailsResult)
    }

    func fetchSimilarMovies(id: Int) -> AnyPublisher<MovieResponse, Error> {
        return publisher(for: similarMoviesResult)
    }

    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCreditsResponse, Error> {
        return publisher(for: movieCreditsResult)
    }

    func addToWishlist(movieID: Int) {
        addedMovieID = movieID
    }

    func removeFromWishlist(movieID: Int) {
        removedMovieID = movieID
    }

    private func publisher<T>(for result: Result<T, Error>?) -> AnyPublisher<T, Error> {
        guard let result = result else {
            return Fail(error: NSError(domain: "MockMoviesRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "No result set in mock"]))
                .eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }
}

