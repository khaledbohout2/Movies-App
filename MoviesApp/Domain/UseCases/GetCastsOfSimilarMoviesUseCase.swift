
import Combine

protocol GetCastsOfSimilarMoviesUseCase {
    func execute(movieIds: [Int]) -> AnyPublisher<Cast, APIError>
}

class GetCastsOfSimilarMoviesUseCaseImp: GetCastsOfSimilarMoviesUseCase {
    private let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func execute(movieIds: [Int]) -> AnyPublisher<Cast, APIError> {
        let publishers = movieIds.map { repository.getMovieCredits(id: $0) }

        return Publishers.MergeMany(publishers)
            .collect()
            .map { responses in
                let allCastMembers = responses.flatMap { $0.cast }
                let allCrewMembers = responses.flatMap { $0.crew }

                var uniqueActorsDict = [Int: CastMember]()
                allCastMembers
                    .filter { $0.knownForDepartment == .acting }
                    .forEach { actor in
                        if uniqueActorsDict[actor.id] == nil {
                            uniqueActorsDict[actor.id] = actor
                        }
                    }
                let uniqueActors = Array(uniqueActorsDict.values)
                    .sorted { $0.popularity > $1.popularity }
                    .prefix(5)

                var uniqueDirectorsDict = [Int: CrewMember]()
                allCrewMembers
                    .filter { $0.knownForDepartment == .directing }
                    .forEach { director in
                        if uniqueDirectorsDict[director.id] == nil {
                            uniqueDirectorsDict[director.id] = director
                        }
                    }
                let uniqueDirectors = Array(uniqueDirectorsDict.values)
                    .sorted { $0.popularity > $1.popularity }
                    .prefix(5)

                return Cast(
                    actors: Array(uniqueActors),
                    directors: Array(uniqueDirectors)
                )
            }
            .eraseToAnyPublisher()
    }

}
