
import Foundation
import Combine

enum ViewModelState<T> {
    case loading
    case loaded(T)
    case error(Error)
}

final class HomeViewModel {

    @Published private(set) var movies: [Movie] = []
    @Published private(set) var state: ViewModelState<[Movie]> = .loading
    @Published var searchText: String = ""
    @Published var page: Int = 1
    @Published var totalPages: Int = 0
    @Published private(set) var isLoadingPage: Bool = false

    var moviesByYear: [(year: String, movies: [Movie])] {
        let groupedDict = Dictionary(grouping: movies) { $0.releaseYear ?? "Unknown" }
        return groupedDict
            .sorted { $0.key > $1.key }
            .map { ($0.key, $0.value) }
    }

    private let coordinator: Coordinator
    private let getPopularMoviesUseCase: GetPopularMoviesUseCase
    private let getsearchMoviesUseCase: SearchMoviesUseCase
    private let getMovieWishlistStatusUseCase: GetMovieWishlistStatusUseCase
    private var cancellables = Set<AnyCancellable>()

    init(coordinator: Coordinator,
         getPopularMoviesUseCase: GetPopularMoviesUseCase,
         getsearchMoviesUseCase: SearchMoviesUseCase,
         getMovieWishlistStatusUseCase: GetMovieWishlistStatusUseCase) {
        self.coordinator = coordinator
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.getsearchMoviesUseCase = getsearchMoviesUseCase
        self.getMovieWishlistStatusUseCase = getMovieWishlistStatusUseCase
    }

    func didLoad() {
        getPopularMovies()
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                guard let self = self else { return }
                self.page = 1
                self.totalPages = 0
                self.movies = []
                if query.isEmpty {
                    self.getPopularMovies()
                } else {
                    self.searchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }

    private func getPopularMovies() {
        state = .loading
        getPopularMoviesUseCase.perform(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies.results)
                self?.page = movies.page + 1
                self?.totalPages = movies.totalPages
                self?.state = .loaded(self?.movies ?? [])
            })
            .store(in: &cancellables)
    }

    private func searchMovies(query: String) {
        getsearchMoviesUseCase.perform(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies.results)
                self?.page = movies.page + 1
                self?.totalPages = movies.totalPages
            })
            .store(in: &cancellables)
    }

    
    func loadMoreIfNeeded(currentIndex: Int) {
        let threshold = 5
        guard !isLoadingPage,
              currentIndex >= movies.count - threshold,
              page <= totalPages else { return }

        isLoadingPage = true

        if searchText.isEmpty {
            getPopularMovies()
        } else {
            searchMovies(query: searchText)
        }
    }

    func didSelectMovie(at indexPath: IndexPath) {
        let movie = moviesByYear[indexPath.section].movies[indexPath.row]
        coordinator.showMovieDetails(movieId: movie.id)
    }

    func refreshWishlistStatus() {
        let updated = movies.map { movie -> Movie in
            var updatedMovie = movie
            updatedMovie.isWishlisted = getMovieWishlistStatusUseCase.execute(movieID: movie.id)
            return updatedMovie
        }
        self.movies = updated
        state = .loaded(updated)
    }

}
