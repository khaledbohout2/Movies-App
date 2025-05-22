//
//  CastCell.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 22/05/2025.
//

import UIKit

class CastCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 32
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        setupLayOut()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayOut() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        imageView.anchor(.top(contentView.topAnchor),
                         .leading(contentView.leadingAnchor),
                         .trailing(contentView.trailingAnchor))

        nameLabel.anchor(.leading(contentView.leadingAnchor, constant: 4),
                         .trailing(contentView.trailingAnchor, constant: 4),
                         .top(imageView.bottomAnchor, constant: 8),
                         .bottom(contentView.bottomAnchor, constant: 8),
                         .height(24))

    }
    
    func configure(name: String, image: String?) {
        nameLabel.text = name
        imageView.load(from: image ?? "")
    }

}

