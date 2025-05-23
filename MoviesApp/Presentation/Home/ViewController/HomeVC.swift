
import UIKit
import Combine

class HomeVC: BaseVC<HomeView> {

    let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelState()
        bindViewModel()
        viewModel.didLoad()
        self.title = "Home"
        mainView.tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        mainView.setDelegates(self)
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
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.mainView.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

}
