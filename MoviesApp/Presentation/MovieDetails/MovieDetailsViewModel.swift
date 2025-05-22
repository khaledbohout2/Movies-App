
import Combine

final class MovieDetailsViewModel {
    private let coordinator: Coordinator
    private var cancellables = Set<AnyCancellable>()
    private let getmovieDetailsUseCase: GetMovieDetailsUseCase
    private let getsimilarMoviesUseCase: GetSimilarMoviesUseCase
    private let getCastsOfSimilarMoviesUseCase: GetCastsOfSimilarMoviesUseCase
    private let movieId: Int

    @Published private(set) var state: ViewModelState = .loading
    @Published var movieDetails: Movie?
    @Published var similarMovies: [Movie] = []
    @Published var castsOfSimilarMovies: Cast = Cast(actors: [], directors: [])

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

    func didLoad() {
        getmovieDetails()
        getsimilarMovies()
    }

    func getmovieDetails() {
        getmovieDetailsUseCase.execute(movieId: movieId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    self?.state = .loaded
                }
            }, receiveValue: { [weak self] movieDetails in
                guard let self else { return }
                self.movieDetails = movieDetails
                self.state = .loaded
            })
            .store(in: &cancellables)
    }

    func getsimilarMovies() {
        getsimilarMoviesUseCase.execute(movieId: movieId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    self?.state = .loaded
                }
            }, receiveValue: { [weak self] similarMovies in
                guard let self else { return }
                self.similarMovies = similarMovies.results
                getCastsOfSimilarMovies()
            })
            .store(in: &cancellables)
    }

    func getCastsOfSimilarMovies() {
        getCastsOfSimilarMoviesUseCase.execute(movieIds: similarMovies.map(\.id))
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    self?.state = .loaded
                }
            }, receiveValue: { [weak self] casts in
                guard let self else { return }
                self.castsOfSimilarMovies = casts
            })
            .store(in: &cancellables)
    }

}
