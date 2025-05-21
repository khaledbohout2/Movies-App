//
//  MoviesRepositoryImp.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Combine

class MockMoviesRepository: MoviesRepository {
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

}
