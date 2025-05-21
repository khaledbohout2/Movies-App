//
//  GetSimilarMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import Combine

protocol GetSimilarMoviesUseCase {
    func execute(movieId: Int) -> AnyPublisher<MovieResponse, Error>
}

class GetSimilarMoviesUseCaseImp: GetSimilarMoviesUseCase {
    private let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func execute(movieId: Int) -> AnyPublisher<MovieResponse, Error> {
        repository.fetchSimilarMovies(id: movieId)
    }
}
