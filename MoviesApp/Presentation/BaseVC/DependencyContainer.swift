
class DependencyContainer {
    lazy var decoder: ResponseDecoder = JSONResponseDecoder()
    lazy var apiClient: APIClientProtocol = APIClient(decoder: decoder)
    lazy var wishlistStorage: WishlistStorage = WishlistManager()
    lazy var moviesRepository: MoviesRepository = MoviesRepositoryImp(apiClient: apiClient, wishlistStorage: wishlistStorage)

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

    lazy var addMovieToWishlistUseCase: AddToWishlistUseCase =
    AddToWishlistUseCaseImp(moviesRepository: moviesRepository)

    lazy var removeFromWishlistUseCase: RemoveFromWishlistUseCase =
    RemoveFromWishlistUseCaseImp(moviesRepository: moviesRepository)
    
    lazy var getMovieWishlistStatusUseCase: GetMovieWishlistStatusUseCase = GetMovieWishlistStatusUseCaseImp(moviesRepository: moviesRepository)
}
