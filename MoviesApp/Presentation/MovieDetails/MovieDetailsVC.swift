//
//  MovieDetailsVC.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import UIKit
import Combine

class MovieDetailsVC: BaseVC<MoviewDetailsView> {
    private let viewModel: MovieDetailsViewModel
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
