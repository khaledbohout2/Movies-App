//
//  SearchMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Combine

protocol SearchMoviesUseCase {
    func perform(query: String, page: Int) -> AnyPublisher<MovieResponse, Error>
}

final class SearchMoviesUseCaseImp: SearchMoviesUseCase {

    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func perform(query: String, page: Int) -> AnyPublisher<MovieResponse, Error> {
        return moviesRepository.searchMovies(query: query, page: page)
    }
}
