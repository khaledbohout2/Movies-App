//
//  GetMovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import Combine

protocol GetMovieDetailsUseCase {
    func execute(movieId: Int) -> AnyPublisher<Movie, Error>
}

class GetMovieDetailsUseCaseImp: GetMovieDetailsUseCase {
    private let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func execute(movieId: Int) -> AnyPublisher<Movie, Error> {
        repository.fetchMovieDetails(id: movieId)
    }
}
