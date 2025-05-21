//
//  MoviesRepository.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Combine

protocol MoviesRepository {
    func getPopularMovies(page: Int) -> AnyPublisher<MovieResponse, Error>
    func searchMovies(query: String, page: Int) -> AnyPublisher<MovieResponse, Error>
    func fetchMovieDetails(id: Int) -> AnyPublisher<Movie, Error>
    func fetchSimilarMovies(id: Int) -> AnyPublisher<MovieResponse, Error>
    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCreditsResponse, Error>
}
