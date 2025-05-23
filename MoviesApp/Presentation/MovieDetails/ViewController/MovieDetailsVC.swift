
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
        mainView.watchListButton.addTarget { [weak self] in
            self?.viewModel.didTapWatchlistButton()
        }
    }

    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.startLoading()
                case .loaded(let movieDetails):
                    self.stopLoading()
                    self.populateMovieDetails(movie: movieDetails)
                case .error(let error):
                    self.stopLoading()
                    self.showSelfDismissingAlert(error.localizedDescription)
                }
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

    private func populateMovieDetails(movie: Movie) {
        mainView.posterImageView.load(from: movie.posterPath ?? "")
        mainView.titleLabel.text = movie.title
        mainView.taglineLabel.text = movie.tagline
        mainView.overviewLabel.text = movie.overview
        mainView.revenueLabel.text = movie.revenue.map(\.description) ?? ""
        mainView.releaseDateLabel.text = movie.releaseDate.map(\.description) ?? ""
        mainView.statusLabel.text = movie.status
        if movie.isWishlisted {
            mainView.watchListButton.setTitle("Remove from Watchlist", for: .normal)
        }
    }

}
