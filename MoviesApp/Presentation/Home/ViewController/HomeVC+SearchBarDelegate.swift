//
//  HomeVC+SearchBarDelegate.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 22/05/2025.
//

import UIKit

extension HomeVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }

}

