//
//  MoviewAPI.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 19/05/2025.
//

import Foundation

enum MovieAPI: APIEndpoint {
    case popular(page: Int)
    case search(query: String, page: Int)
    case getMovieDetails(id: Int)
    case getSimilarMovies(id: Int)
    case getMovieCredits(id: Int)

    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .search:
            return "/search/movie"
        case .getMovieDetails:
            return "/movies/get-movie-details"
        case .getSimilarMovies:
            return "/movies/get-similar-movies"
        case .getMovieCredits:
            return "/movies/get-movie-credits"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }

    var queryParameters: [URLQueryItem]? {
        switch self {
        case .getMovieDetails(let id):
            return [URLQueryItem(name: "movie_id", value: "\(id)")]
        case .popular(let page):
            return [URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "\(page)")]
        case .search(let query, let page):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "include_adult", value: "false")
            ]
        case .getSimilarMovies(let id):
            return [URLQueryItem(name: "movie_id", value: "\(id)")]
        case .getMovieCredits(let id):
            return [URLQueryItem(name: "movie_id", value: "\(id)")]
        }
    }

    var body: Data? { nil }
}
