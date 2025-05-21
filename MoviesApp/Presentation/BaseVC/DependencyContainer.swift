//
//  DependencyContainer.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

class DependencyContainer {
    lazy var apiClient: APIClientProtocol = APIClient()
    lazy var moviesRepository: MoviesRepository = MockMoviesRepository(apiClient: apiClient)
    
    lazy var getPopularMoviesUseCase: GetPopularMoviesUseCase =
        GetPopularMoviesUseCaseImp(moviesRepository: moviesRepository)

    lazy var searchMoviesUseCase: SearchMoviesUseCase =
        SearchMoviesUseCaseImp(moviesRepository: moviesRepository)
}
