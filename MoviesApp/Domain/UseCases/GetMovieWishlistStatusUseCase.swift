//
//  GetMovieWishlistStatusUseCase.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 23/05/2025.
//

import Foundation

protocol GetMovieWishlistStatusUseCase {
    func execute(movieID: Int) -> Bool
}

final class GetMovieWishlistStatusUseCaseImp: GetMovieWishlistStatusUseCase {
    private let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func execute(movieID: Int) -> Bool {
        moviesRepository.wishListContains(movieID: movieID)
    }
}
