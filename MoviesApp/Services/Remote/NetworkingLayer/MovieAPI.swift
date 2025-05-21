//
//  MoviewAPI.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 19/05/2025.
//

import Foundation

enum MovieAPI: APIEndpoint {
    case popular
    case search(query: String)
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .search:
            return "/search/movie"
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
        case .popular:
            return [URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1")]
        case .search(let query):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "include_adult", value: "false")
            ]
        }
    }

    var body: Data? { nil }
}


