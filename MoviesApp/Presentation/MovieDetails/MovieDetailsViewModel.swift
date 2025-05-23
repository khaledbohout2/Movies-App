
import Combine

final class MovieDetailsViewModel {
    private let coordinator: Coordinator
    private var cancellables = Set<AnyCancellable>()
    private let getmovieDetailsUseCase: GetMovieDetailsUseCase
    private let getsimilarMoviesUseCase: GetSimilarMoviesUseCase
    private let getCastsOfSimilarMoviesUseCase: GetCastsOfSimilarMoviesUseCase
    private let addToWishlistUseCase: AddToWishlistUseCase
    private let removeFromWishlistUseCase: RemoveFromWishlistUseCase
    private let movieId: Int

    @Published private(set) var state: ViewModelState<Movie> = .loading
    @Published var movieDetails: Movie?
    @Published var similarMovies: [Movie] = []
    @Published var castsOfSimilarMovies: Cast = Cast(actors: [], directors: [])

    init(movieId: Int,
         coordinator: Coordinator,
         getmovieDetailsUseCase: GetMovieDetailsUseCase,
         getsimilarMoviesUseCase: GetSimilarMoviesUseCase,
         getCastsOfSimilarMoviesUseCase: GetCastsOfSimilarMoviesUseCase,
         addToWishlistUseCase: AddToWishlistUseCase,
         removeFromWishlistUseCase: RemoveFromWishlistUseCase) {
        self.movieId = movieId
        self.coordinator = coordinator
        self.getmovieDetailsUseCase = getmovieDetailsUseCase
        self.getsimilarMoviesUseCase = getsimilarMoviesUseCase
        self.getCastsOfSimilarMoviesUseCase = getCastsOfSimilarMoviesUseCase
        self.addToWishlistUseCase = addToWishlistUseCase
        self.removeFromWishlistUseCase = removeFromWishlistUseCase
    }

    func didLoad() {
        getMovieDetails()
        getSimilarMovies()
    }

    private func getMovieDetails() {
        state = .loading
        getmovieDetailsUseCase.execute(movieId: movieId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] movieDetails in
                guard let self else { return }
                self.movieDetails = movieDetails
                self.state = .loaded(movieDetails)
            })
            .store(in: &cancellables)
    }

    private func getSimilarMovies() {
        getsimilarMoviesUseCase.execute(movieId: movieId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] similarMovies in
                guard let self else { return }
                self.similarMovies = similarMovies
                getCastsOfSimilarMovies()
            })
            .store(in: &cancellables)
    }

    private func getCastsOfSimilarMovies() {
        getCastsOfSimilarMoviesUseCase.execute(movieIds: similarMovies.map(\.id))
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] casts in
                guard let self else { return }
                self.castsOfSimilarMovies = casts
            })
            .store(in: &cancellables)
    }

    private func addToWatchlist() {
        addToWishlistUseCase.execute(movieID: movieId)
    }

    private func removeFromWatchlist() {
        removeFromWishlistUseCase.execute(movieID: movieId)
    }

    func didTapWatchlistButton() {
        if movieDetails?.isWishlisted ?? false {
            removeFromWatchlist()
            movieDetails?.isWishlisted = false
        } else {
            addToWatchlist()
            movieDetails?.isWishlisted = true
        }
    }

}
