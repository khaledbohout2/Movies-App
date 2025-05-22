
class DependencyContainer {
    lazy var apiClient: APIClientProtocol = APIClient()
    lazy var moviesRepository: MoviesRepository = MoviesRepositoryImp(apiClient: apiClient)

    lazy var getPopularMoviesUseCase: GetPopularMoviesUseCase =
        GetPopularMoviesUseCaseImp(moviesRepository: moviesRepository)

    lazy var searchMoviesUseCase: SearchMoviesUseCase =
        SearchMoviesUseCaseImp(moviesRepository: moviesRepository)

    lazy var getMovieDetailsUseCase: GetMovieDetailsUseCase =
    GetMovieDetailsUseCaseImp(repository: moviesRepository)

    lazy var getSimilarMoviesUseCase: GetSimilarMoviesUseCase =
    GetSimilarMoviesUseCaseImp(repository: moviesRepository)
    
    lazy var getCastsOfSimilarMoviesUseCase: GetCastsOfSimilarMoviesUseCase =
    GetCastsOfSimilarMoviesUseCaseImp(repository: moviesRepository)
}
