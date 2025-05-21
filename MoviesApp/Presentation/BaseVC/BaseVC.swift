//
//  BaseVC.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import UIKit

class BaseVC<T: BaseView>: UIViewController {

    final var mainView = T()

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
