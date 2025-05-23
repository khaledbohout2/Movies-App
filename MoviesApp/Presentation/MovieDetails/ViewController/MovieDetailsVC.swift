
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
        bindViewModelState()
        bindViewModel()
        viewModel.didLoad()
        mainView.watchListButton.addTarget { [weak self] in
            self?.viewModel.didTapWatchlistButton()
        }
    }
    
    private func bindViewModelState() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.startLoading()
                case .loaded:
                    self.stopLoading()
                case .error(let error):
                    self.stopLoading()
                    self.showSelfDismissingAlert(error.localizedDescription)
                }
            }
            .store(in: &cancellables)
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
        if viewModel.movieDetails?.isWishlisted ?? false {
            mainView.watchListButton.setTitle("Remove from Watchlist", for: .normal)
        }
    }

}
