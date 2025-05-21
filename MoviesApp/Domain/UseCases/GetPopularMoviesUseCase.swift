//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Combine

protocol GetPopularMoviesUseCase {
    func perform(page: Int) -> AnyPublisher<MovieResponse, Error>
}

final class GetPopularMoviesUseCaseImp: GetPopularMoviesUseCase {

    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func perform(page: Int) -> AnyPublisher<MovieResponse, Error> {
        return moviesRepository.getPopularMovies(page: page)
    }
}
