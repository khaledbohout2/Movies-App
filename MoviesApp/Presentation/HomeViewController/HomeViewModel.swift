//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Foundation
import Combine

enum ViewModelState {
    case loading
    case loaded([Movie])
    case error(Error)
}

final class HomeViewModel {
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var state: ViewModelState = .loading
    @Published var searchText: String = ""

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
                    if query.isEmpty {
                        self.fetchPopularMovies()
                    } else {
                        self.searchMovies(query: query)
                    }
                }
                .store(in: &cancellables)
    }

    private func searchMovies(query: String) {
        getsearchMoviesUseCase.perform(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }

    func fetchPopularMovies() {
        getPopularMoviesUseCase.perform()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }

}
