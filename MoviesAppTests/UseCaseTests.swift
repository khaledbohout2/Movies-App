import XCTest
import Combine
@testable import MoviesApp

final class UseCaseTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var mockRepository: MockMoviesRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMoviesRepository()
    }

    override func tearDown() {
        cancellables.removeAll()
        mockRepository = nil
        super.tearDown()
    }

    func testAddToWishlistUseCase_callsRepository() {
        let useCase = AddToWishlistUseCaseImp(moviesRepository: mockRepository)
        useCase.execute(movieID: 42)
        XCTAssertEqual(mockRepository.addedMovieID, 42)
    }

    func testRemoveFromWishlistUseCase_callsRepository() {
        let useCase = RemoveFromWishlistUseCaseImp(moviesRepository: mockRepository)
        useCase.execute(movieID: 101)
        XCTAssertEqual(mockRepository.removedMovieID, 101)
    }

    func testGetPopularMoviesUseCase_returnsMovies() {
        let movie = MovieBuilder()
            .withId(1)
            .withTitle("Test")
            .build()

        let response = MovieResponseBuilder()
            .withResults([movie])
            .withPage(1)
            .withTotalPages(1)
            .build()

        mockRepository.popularMoviesResult = .success(response)

        let useCase = GetPopularMoviesUseCaseImp(moviesRepository: mockRepository)
        let expectation = self.expectation(description: "getPopularMovies")

        useCase.perform(page: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { movieResponse in
                XCTAssertEqual(movieResponse.results.count, 1)
                XCTAssertEqual(movieResponse.results.first?.title, "Test")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testSearchMoviesUseCase_returnsMovies() {
        let movie = MovieBuilder()
            .withId(2)
            .withTitle("SearchTest")
            .build()

        let response = MovieResponseBuilder()
            .withResults([movie])
            .build()

        mockRepository.searchMoviesResult = .success(response)

        let useCase = SearchMoviesUseCaseImp(moviesRepository: mockRepository)
        let expectation = self.expectation(description: "searchMovies")

        useCase.perform(query: "query", page: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { movieResponse in
                XCTAssertEqual(movieResponse.results.first?.title, "SearchTest")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetMovieDetailsUseCase_returnsMovie() {
        let movie = MovieBuilder()
            .withId(3)
            .withTitle("Details")
            .build()

        mockRepository.movieDetailsResult = .success(movie)

        let useCase = GetMovieDetailsUseCaseImp(repository: mockRepository)
        let expectation = self.expectation(description: "getMovieDetails")

        useCase.execute(movieId: 3)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { movie in
                XCTAssertEqual(movie.title, "Details")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetSimilarMoviesUseCase_returnsTop5Movies() {
        let movies = (1...10).map { i in
            MovieBuilder().withId(i).withTitle("Movie \(i)").build()
        }

        let response = MovieResponseBuilder()
            .withResults(movies)
            .build()

        mockRepository.similarMoviesResult = .success(response)

        let useCase = GetSimilarMoviesUseCaseImp(repository: mockRepository)
        let expectation = self.expectation(description: "getSimilarMovies")

        useCase.execute(movieId: 5)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { movies in
                XCTAssertEqual(movies.count, 5)
                XCTAssertEqual(movies.first?.id, 1)
                XCTAssertEqual(movies.last?.id, 5)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testGetMovieCreditsUseCase_returnsCredits() {
        let castMember = CastMemberBuilder()
            .withId(1)
            .withName("Actor One")
            .build()

        let crewMember = CrewMemberBuilder()
            .withId(2)
            .withName("Director One")
            .withJob("Director")
            .build()

        let credits = MovieCreditsBuilder()
            .withId(99)
            .withCast([castMember])
            .withCrew([crewMember])
            .build()

        mockRepository.movieCreditsResult = .success(credits)

        let useCase = GetCastsOfSimilarMoviesUseCaseImp(repository: mockRepository)
        let expectation = self.expectation(description: "getMovieCredits")

        useCase.execute(movieIds: [99])
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.actors.count, 1)
                XCTAssertEqual(response.directors.count, 1)
                XCTAssertEqual(response.actors.first?.name, "Actor One")
                XCTAssertEqual(response.directors.first?.job, "Director")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

}


