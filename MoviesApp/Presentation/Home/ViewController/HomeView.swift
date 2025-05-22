//
//  HomeView.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import UIKit

class HomeView: BaseView {

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func setupView() {
        super.setupView()
        addSubview(searchBar)
        addSubview(tableView)
        
        searchBar.anchor(.leading(leadingAnchor, constant: 8),
                         .trailing(trailingAnchor, constant: 8),
                         .top(topAnchor, constant: 100),
                         .height(44))
        
        tableView.anchor(.leading(leadingAnchor),
                         .trailing(trailingAnchor),
                         .top(searchBar.bottomAnchor),
                         .bottom(bottomAnchor))
    }

    func setDelegates(_ delegate: UISearchBarDelegate & UITableViewDelegate & UITableViewDataSource) {
        searchBar.delegate = delegate
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }

}
