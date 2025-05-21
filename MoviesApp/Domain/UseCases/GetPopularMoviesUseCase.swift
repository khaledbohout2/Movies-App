//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Combine

protocol GetPopularMoviesUseCase {
    func perform() -> AnyPublisher<[Movie], Error>
}

final class GetPopularMoviesUseCaseImp: GetPopularMoviesUseCase {

    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func perform() -> AnyPublisher<[Movie], Error> {
        return moviesRepository.getPopularMovies()
    }
}
