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

    func getPopularMovies() -> AnyPublisher<[Movie], Error> {
        return apiClient.request(MovieAPI.popular, responseType: MovieResponse.self)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func searchMovies(query: String) -> AnyPublisher<[Movie], Error> {
        return apiClient.request(MovieAPI.search(query: query), responseType: MovieResponse.self)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

}
