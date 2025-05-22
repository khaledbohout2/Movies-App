//
//  MovieDetailsVC+UICollectionViewDelegates.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 22/05/2025.
//

import UIKit

extension MovieDetailsVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == mainView.castsOfSimilarMoviesCV {
            return 2
        } else if collectionView == mainView.similarMoviesCV {
            return 1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.castsOfSimilarMoviesCV {
            switch section {
            case 0:
                return viewModel.castsOfSimilarMovies.actors.count
            case 1:
                return viewModel.castsOfSimilarMovies.directors.count
            default:
                return 0
            }
        } else if collectionView == mainView.similarMoviesCV {
            return viewModel.similarMovies.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == mainView.castsOfSimilarMoviesCV {
            let cell: CastCell = collectionView.forceDequeueCell(identifier: CastCell.identifier, for: indexPath)

            if indexPath.section == 0 {
                let actor = viewModel.castsOfSimilarMovies.actors[indexPath.item]
                cell.configure(name: actor.name, image: actor.profilePath)
            } else {
                let director = viewModel.castsOfSimilarMovies.directors[indexPath.item]
                cell.configure(name: director.name, image: director.profilePath)
            }

            return cell

        } else if collectionView == mainView.similarMoviesCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }

            let movie = viewModel.similarMovies[indexPath.item]
            cell.configure(with: movie)
            return cell
        }

        return UICollectionViewCell()
    }
}

extension MovieDetailsVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == mainView.castsOfSimilarMoviesCV {
            return CGSize(width: 80, height: 110)
        } else if collectionView == mainView.similarMoviesCV {
            let width = (collectionView.frame.width - 10) / 2
            return CGSize(width: width, height: width * 1.5)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

