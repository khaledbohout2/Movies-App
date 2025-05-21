//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import Combine

final class MovieDetailsViewModel {
    private let coordinator: Coordinator
    private var cancellables = Set<AnyCancellable>()
    private let getmovieDetailsUseCase: GetMovieDetailsUseCase
    private let getsimilarMoviesUseCase: GetSimilarMoviesUseCase
    private let getCastsOfSimilarMoviesUseCase: GetCastsOfSimilarMoviesUseCase
    private let movieId: Int

    init(movieId: Int,
         coordinator: Coordinator,
         getmovieDetailsUseCase: GetMovieDetailsUseCase,
         getsimilarMoviesUseCase: GetSimilarMoviesUseCase,
         getCastsOfSimilarMoviesUseCase: GetCastsOfSimilarMoviesUseCase) {
        self.movieId = movieId
        self.coordinator = coordinator
        self.getmovieDetailsUseCase = getmovieDetailsUseCase
        self.getsimilarMoviesUseCase = getsimilarMoviesUseCase
        self.getCastsOfSimilarMoviesUseCase = getCastsOfSimilarMoviesUseCase
    }
}
