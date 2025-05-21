//
//  Untitled.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupAppearance()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setupAppearance() {
        backgroundColor = .white
    }

    func setupView() {}
}
