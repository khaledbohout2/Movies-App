
import Foundation
import Combine

enum ViewModelState {
    case loading
    case loaded
    case error(Error)
}

final class HomeViewModel {

    @Published private(set) var movies: [Movie] = []
    @Published private(set) var state: ViewModelState = .loading
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
    private var cancellables = Set<AnyCancellable>()

    init(coordinator: Coordinator,
         getPopularMoviesUseCase: GetPopularMoviesUseCase,
         getsearchMoviesUseCase: SearchMoviesUseCase) {
        self.coordinator = coordinator
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.getsearchMoviesUseCase = getsearchMoviesUseCase
    }

    func didLoad() {
        fetchPopularMovies()
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                guard let self = self else { return }
                self.page = 1
                self.totalPages = 0
                self.movies = []
                if query.isEmpty {
                    self.fetchPopularMovies()
                } else {
                    self.searchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }

    private func fetchPopularMovies() {
        getPopularMoviesUseCase.perform(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
                self?.isLoadingPage = false
            }, receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies.results)
                self?.page = movies.page + 1
                self?.totalPages = movies.totalPages
            })
            .store(in: &cancellables)
    }

    private func searchMovies(query: String) {
        getsearchMoviesUseCase.perform(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
                self?.isLoadingPage = false
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
            fetchPopularMovies()
        } else {
            searchMovies(query: searchText)
        }
    }

    func didSelectMovie(at indexPath: IndexPath) {
        let movie = moviesByYear[indexPath.section].movies[indexPath.row]
        coordinator.showMovieDetails(movieId: movie.id)
    }

}
