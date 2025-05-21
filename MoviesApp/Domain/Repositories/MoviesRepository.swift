//
//  MoviesRepository.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Combine

protocol MoviesRepository {
    func getPopularMovies() -> AnyPublisher<[Movie], Error>
    func searchMovies(query: String) -> AnyPublisher<[Movie], Error>
}
