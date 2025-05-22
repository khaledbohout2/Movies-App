//
//  HomeVC.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

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
        bindViewModel()
        viewModel.didLoad()
        self.title = "Home"
        mainView.tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        mainView.setDelegates(self)
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
