//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Foundation
import Combine

final class HomeViewModel {
    private let coordinator: Coordinator
    private let getpopularMoviesUseCase: GetPopularMoviesUseCase
    private let getsearchMoviesUseCase: SearchMoviesUseCase
    
    init(coordinator: Coordinator,
         getpopularMoviesUseCase: GetPopularMoviesUseCase,
         getsearchMoviesUseCase: SearchMoviesUseCase) {
        self.coordinator = coordinator
        self.getpopularMoviesUseCase = getpopularMoviesUseCase
        self.getsearchMoviesUseCase = getsearchMoviesUseCase
    }
}
