//
//  MoviewDetailsView.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import UIKit

class MoviewDetailsView: BaseView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    lazy var movieDetailsVCont: UIView = {
        let view = UIView()
        return view
    }()

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    lazy var revenueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    lazy var watchListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Watch List", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    lazy var simialarMoviesView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var similarMoviesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Similar Movies"
        return label
    }()

    lazy var similarMoviesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
        collectionView.register(MovieCell.self,
                                forCellWithReuseIdentifier: MovieCell.identifier)
        return collectionView
    }()
    
    lazy var castsOfSimilarMoviesView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var castsOfSimilarMoviesLbl: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Casts of Similar Movies"
        return label
    }()
    
    lazy var castsOfSimilarMoviesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
        collectionView.register(CastCell.self,
                                forCellWithReuseIdentifier: CastCell.identifier)
        return collectionView
    }()

    override func setupView() {
        super.setupView()
        addScrollView()
        addMovieDetailsView()
        addSimilarMoviesView()
        addCastsOfSimilarMoviesView()
    }

    func addScrollView() {
        addSubview(scrollView)
        scrollView.fillSuperviewSafeArea()

        scrollView.addSubview(stackView)
        stackView.fillSuperview()

        let widthConstraint = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        widthConstraint.isActive = true

        let heightConstraint = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = .init(250)
        heightConstraint.isActive = true
    }

    func addMovieDetailsView() {
        stackView.addArrangedSubview(movieDetailsVCont)

        movieDetailsVCont.addSubview(posterImageView)
        movieDetailsVCont.addSubview(titleLabel)
        movieDetailsVCont.addSubview(taglineLabel)
        movieDetailsVCont.addSubview(overviewLabel)
        movieDetailsVCont.addSubview(revenueLabel)
        movieDetailsVCont.addSubview(releaseDateLabel)
        movieDetailsVCont.addSubview(statusLabel)
        movieDetailsVCont.addSubview(watchListButton)

        posterImageView.anchor(.top(movieDetailsVCont.topAnchor, constant: 16),
                               .leading(movieDetailsVCont.leadingAnchor, constant: 16),
                               .trailing(movieDetailsVCont.trailingAnchor, constant: 16),
                               .height(250))

        titleLabel.anchor(.top(posterImageView.bottomAnchor, constant: 12),
                          .leading(posterImageView.leadingAnchor),
                          .trailing(posterImageView.trailingAnchor))

        taglineLabel.anchor(.top(titleLabel.bottomAnchor, constant: 8),
                            .leading(titleLabel.leadingAnchor),
                            .trailing(titleLabel.trailingAnchor))

        overviewLabel.anchor(.top(taglineLabel.bottomAnchor, constant: 8),
                             .leading(titleLabel.leadingAnchor),
                             .trailing(titleLabel.trailingAnchor))

        revenueLabel.anchor(.top(overviewLabel.bottomAnchor, constant: 8),
                            .leading(titleLabel.leadingAnchor),
                            .trailing(titleLabel.trailingAnchor))

        releaseDateLabel.anchor(.top(revenueLabel.bottomAnchor, constant: 8),
                                .leading(titleLabel.leadingAnchor),
                                .trailing(titleLabel.trailingAnchor))

        statusLabel.anchor(.top(releaseDateLabel.bottomAnchor, constant: 8),
                           .leading(titleLabel.leadingAnchor),
                           .trailing(titleLabel.trailingAnchor))

        watchListButton.anchor(.top(statusLabel.bottomAnchor, constant: 16),
                               .leading(titleLabel.leadingAnchor),
                               .trailing(titleLabel.trailingAnchor),
                               .height(50),
                               .bottom(movieDetailsVCont.bottomAnchor, constant: 24))
    }

    func addSimilarMoviesView() {
        stackView.addArrangedSubview(simialarMoviesView)

        simialarMoviesView.addSubview(similarMoviesLabel)
        simialarMoviesView.addSubview(similarMoviesCV)

        similarMoviesLabel.anchor(
            .top(simialarMoviesView.topAnchor, constant: 16),
            .leading(simialarMoviesView.leadingAnchor, constant: 16),
            .trailing(simialarMoviesView.trailingAnchor, constant: 16)
        )

        similarMoviesCV.anchor(
            .top(similarMoviesLabel.bottomAnchor, constant: 12),
            .leading(simialarMoviesView.leadingAnchor, constant: 0),
            .trailing(simialarMoviesView.trailingAnchor, constant: 0),
            .bottom(simialarMoviesView.bottomAnchor, constant: 16),
            .height(200)
        )
    }
    
    func addCastsOfSimilarMoviesView() {
        stackView.addArrangedSubview(castsOfSimilarMoviesView)

        castsOfSimilarMoviesView.addSubview(castsOfSimilarMoviesLbl)
        castsOfSimilarMoviesView.addSubview(castsOfSimilarMoviesCV)

        castsOfSimilarMoviesLbl.anchor(
            .top(castsOfSimilarMoviesView.topAnchor, constant: 16),
            .leading(castsOfSimilarMoviesView.leadingAnchor, constant: 16),
            .trailing(castsOfSimilarMoviesView.trailingAnchor, constant: 16)
        )

        castsOfSimilarMoviesCV.anchor(
            .top(castsOfSimilarMoviesLbl.bottomAnchor, constant: 12),
            .leading(castsOfSimilarMoviesView.leadingAnchor),
            .trailing(castsOfSimilarMoviesView.trailingAnchor),
            .bottom(castsOfSimilarMoviesView.bottomAnchor, constant: 16),
            .height(200)
        )
    }

    func setDelegates(_ delegate: AnyObject) {
        similarMoviesCV.delegate = delegate as? UICollectionViewDelegate
        castsOfSimilarMoviesCV.delegate = delegate as? UICollectionViewDelegate
        similarMoviesCV.dataSource = delegate as? UICollectionViewDataSource
        castsOfSimilarMoviesCV.dataSource = delegate as? UICollectionViewDataSource
    }

}
