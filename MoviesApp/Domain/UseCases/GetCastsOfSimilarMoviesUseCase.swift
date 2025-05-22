//
//  GetCastsOfSimilarMoviesUseCase.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import Combine

protocol GetCastsOfSimilarMoviesUseCase {
    func execute(movieIds: [Int]) -> AnyPublisher<Cast, Error>
}

class GetCastsOfSimilarMoviesUseCaseImp: GetCastsOfSimilarMoviesUseCase {
    private let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func execute(movieIds: [Int]) -> AnyPublisher<Cast, Error> {
        let publishers = movieIds.map { repository.fetchMovieCredits(id: $0) }

        return Publishers.MergeMany(publishers)
            .collect()
            .map { responses in
                let allCastMembers = responses.flatMap { $0.cast }
                let allCrewMembers = responses.flatMap { $0.crew }

                let actors = allCastMembers
                    .filter { $0.knownForDepartment.lowercased() == "acting" }
                    .sorted { $0.popularity > $1.popularity }
                    .prefix(5)

                let directors = allCrewMembers
                    .filter { $0.knownForDepartment.lowercased() == "directing" && $0.job.lowercased() == "director" }
                    .sorted { $0.popularity > $1.popularity }
                    .prefix(5)

                return Cast(
                    actors: Array(actors),
                    directors: Array(directors)
                )
            }
            .eraseToAnyPublisher()
    }
}
