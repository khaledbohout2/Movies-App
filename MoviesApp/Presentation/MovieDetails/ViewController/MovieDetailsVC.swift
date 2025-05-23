
import UIKit
import Combine

class MovieDetailsVC: BaseVC<MoviewDetailsView> {
    let viewModel: MovieDetailsViewModel
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Details"
        mainView.setDelegates(self)
        bindViewModel()
        viewModel.didLoad()
    }

    private func bindViewModel() {
        viewModel.$movieDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                self?.populateMovieDetails()
            }
            .store(in: &cancellables)

        viewModel.$similarMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.mainView.similarMoviesCV.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$castsOfSimilarMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.mainView.actorsOfSimilarMoviesCV.reloadData()
                self?.mainView.directorsOfSimilarMoviesCV.reloadData()
            }
            .store(in: &cancellables)
    }

    private func populateMovieDetails() {
        mainView.posterImageView.load(from: viewModel.movieDetails?.posterPath ?? "")
        mainView.titleLabel.text = viewModel.movieDetails?.title
        mainView.taglineLabel.text = viewModel.movieDetails?.tagline
        mainView.overviewLabel.text = viewModel.movieDetails?.overview
        mainView.revenueLabel.text = viewModel.movieDetails?.revenue.map(\.description) ?? ""
        mainView.releaseDateLabel.text = viewModel.movieDetails?.releaseDate.map(\.description) ?? ""
        mainView.statusLabel.text = viewModel.movieDetails?.status
    }

}
