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
    }

    func fetchPopularMovies() {
        getPopularMoviesUseCase.perform()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error)
                    print(error)
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }

}
